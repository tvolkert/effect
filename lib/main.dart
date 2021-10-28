import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const FooProducer());
}

class FooProducer extends StatefulWidget {
  const FooProducer({Key? key}) : super(key: key);

  @override
  State<FooProducer> createState() => _FooProducerState();
}

typedef PhotoDisappearedCallback = void Function(int uid);

class _FooProducerState extends State<FooProducer> {
  final List<FloatingPhoto> children = <FloatingPhoto>[];
  final Map<int, FloatingPhoto> childrenByUid = <int, FloatingPhoto>{};
  late Timer timer;
  int i = 0;

  static int _nextUid = 0;

  static const List<AssetImage> images = <AssetImage>[
    AssetImage('assets/DSC_0013.jpg'),
    AssetImage('assets/DSC_0021-2.jpg'),
    AssetImage('assets/DSC_0135-2.jpg'),
    AssetImage('assets/DSC_0256.jpg'),
    AssetImage('assets/IMG_20150220_174328408_HDR.jpg'),
    AssetImage('assets/Image13.jpeg'),
    AssetImage('assets/P1010073.jpg'),
    AssetImage('assets/TCV_7314.jpg'),
    AssetImage('assets/TCV_8294.jpg'),
  ];

  void _handlePhotoDisappeared(int uid) {
    final FloatingPhoto? child = childrenByUid.remove(uid);
    if (child != null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            children.remove(child);
          });
        }
      });
    }
  }

  FloatingPhoto newChild() {
    final FloatingPhoto result = FloatingPhoto(image: images[i], uid: _nextUid++);
    i = (i + 1) % images.length;
    return result;
  }

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      if (mounted) {
        setState(() {
          final FloatingPhoto child = newChild();
          children.add(child);
          childrenByUid[child.uid] = child;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhotoMontage(
      children: children,
      onPhotoDisappeared: _handlePhotoDisappeared,
    );
  }
}

class PhotoMontage extends MultiChildRenderObjectWidget {
  PhotoMontage({
    Key? key,
    required List<FloatingPhoto> children,
    required this.onPhotoDisappeared,
    this.transform,
  }) : super(key: key, children: children);

  final PhotoDisappearedCallback onPhotoDisappeared;
  final Matrix4? transform;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPhotoMontage(
      onPhotoDisappeared: onPhotoDisappeared,
      transform: transform,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPhotoMontage renderObject) {
    renderObject
      ..onPhotoDisappeared = onPhotoDisappeared
      ..transform = transform;
  }
}

class RenderPhotoMontage extends RenderBox with ContainerRenderObjectMixin<RenderFloatingPhoto, _PhotoMontageParentData>, RenderBoxContainerDefaultsMixin<RenderFloatingPhoto, _PhotoMontageParentData> {
  RenderPhotoMontage({
    required this.onPhotoDisappeared,
    int frame = 1,
    Matrix4? transform,
  }) {
    this.frame = frame;
    this.transform = transform;
  }

  PhotoDisappearedCallback onPhotoDisappeared;

  int _frame = 1;
  int get frame => _frame;
  set frame(int value) {
    if (value != _frame) {
      _frame = value;
      markNeedsPaint();
    }
  }

  int? _frameCallbackId;
  void _scheduleFrame([bool rescheduling = false]) {
    _frameCallbackId = SchedulerBinding.instance!.scheduleFrameCallback(
      _handleFrame,
      rescheduling: rescheduling,
    );
  }

  void _cancelFrame() {
    assert(_frameCallbackId != null);
    SchedulerBinding.instance!.cancelFrameCallbackWithId(_frameCallbackId!);
    _frameCallbackId = null;
  }

  void _handleFrame(Duration timeStamp) {
    frame++;
    if (childCount > 0) {
      _scheduleFrame(true);
    } else {
      _frameCallbackId = null;
    }
  }

  Matrix4? _transform;
  Matrix4? get transform => _transform;
  set transform(Matrix4? value) {
    if (value != _transform) {
      _transform = value;
      markNeedsPaint();
    }
  }

  @override
  void insert(RenderFloatingPhoto child, { RenderFloatingPhoto? after }) {
    print('inserting $child');
    final bool isFirstChild = childCount == 0;
    super.insert(child, after: after);
    if (attached && isFirstChild) {
      _scheduleFrame();
    }
  }

  @override
  void remove(RenderFloatingPhoto child) {
    print('removing $child');
    super.remove(child);
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _PhotoMontageParentData) {
      child.parentData = _PhotoMontageParentData(startFrame: frame);
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    assert(_frameCallbackId == null);
    if (childCount > 0) {
      _scheduleFrame();
    }
  }

  @override
  void detach() {
    if (childCount > 0) {
      _cancelFrame();
    } else {
      assert(_frameCallbackId == null);
    }
    super.detach();
  }

  @override
  void performLayout() {
    RenderFloatingPhoto? child = firstChild;
    while (child != null) {
      child.layout(const BoxConstraints());
      final _PhotoMontageParentData childParentData = child.parentData as _PhotoMontageParentData;
      childParentData.offset = Offset.zero;
      child = childParentData.nextSibling;
    }
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderFloatingPhoto? child = firstChild;
    print('painting -- $child');
    while (child != null) {
      final _PhotoMontageParentData childParentData = child.parentData! as _PhotoMontageParentData;
      if (transform == null) {
        context.paintChild(child, childParentData.offset + offset);
      } else {
        context.pushTransform(needsCompositing, offset, transform!, (PaintingContext context, Offset offset) {
          context.paintChild(child!, childParentData.offset + offset);
        });
      }
      if (frame - childParentData.startFrame > 100) {
        onPhotoDisappeared(child.uid);
      }
      child = childParentData.nextSibling;
    }
  }
}

class _PhotoMontageParentData extends ContainerBoxParentData<RenderFloatingPhoto> {
  _PhotoMontageParentData({required this.startFrame});

  final int startFrame;
}

class FloatingPhoto extends StatefulWidget {
  const FloatingPhoto({
    Key? key,
    required this.image,
    required this.uid,
  }) : super(key: key);

  final ImageProvider image;
  final int uid;

  @override
  State<FloatingPhoto> createState() => _FloatingPhotoState();
}

class _FloatingPhotoState extends State<FloatingPhoto> {
  late ImageStream _stream;
  late ImageStreamListener _listener;
  ui.Image? _image;

  void _handleImage(ImageInfo? imageInfo, bool sync) {
    setState(() {
      _disposeImage();
      _image = imageInfo!.image;
    });
  }

  void _handleError(Object exception, StackTrace? stackTrace) {
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to precache'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  }

  void _disposeImage() {
    if (_image != null) {
      _image!.dispose();
      _image = null;
    }
  }

  @override
  void initState() {
    super.initState();
    final ImageConfiguration config = createLocalImageConfiguration(context);
    _listener = ImageStreamListener(_handleImage, onError: _handleError);
    _stream = widget.image.resolve(config)..addListener(_listener);
  }

  @override
  void dispose() {
    print('disposing image');
    _stream.removeListener(_listener);
    _disposeImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RawFloatingPhoto(image: _image, uid: widget.uid);
  }
}

class _RawFloatingPhoto extends LeafRenderObjectWidget {
  const _RawFloatingPhoto({
    Key? key,
    required this.image,
    required this.uid,
  }) : super(key: key);

  final ui.Image? image;
  final int uid;

  @override
  RenderFloatingPhoto createRenderObject(BuildContext context) {
    return RenderFloatingPhoto(image: image, uid: uid);
  }

  @override
  void updateRenderObject(BuildContext context, RenderFloatingPhoto renderObject) {
    renderObject.image = image;
  }
}

class RenderFloatingPhoto extends RenderBox {
  RenderFloatingPhoto({
    required this.uid,
    required ui.Image? image,
  }) {
    this.image = image;
  }

  final int uid;

  ui.Image? _image;
  ui.Image? get image => _image;
  set image(ui.Image? value) {
    if (value != _image) {
      _image = value;
      markParentNeedsLayout();
    }
  }

  double _scale = 1;
  double get scale => _scale;
  set scale(double value) {
    if (value != _scale) {
      _scale = value;
      markNeedsPaint();
    }
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return image == null ? Size.zero : Size(image!.width.toDouble(), image!.height.toDouble());
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (image == null) {
      return;
    }
    paintImage(
      image: image!,
      canvas: context.canvas,
      rect: offset & size,
      scale: scale,
      alignment: Alignment.topLeft,
    );
  }
}
