import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

const _debugExtraInfo = false;
const _rotationInterval = Duration(seconds: 10);

const double perspectiveAngleRadians = 0.4315;

const List<AssetImage> images = <AssetImage>[
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

class Layer2 {
  const Layer2({
    required this.spread,
    required this.scale,
    required this.zIndex,
    required this.speed,
    required this.color,
  });

  final double spread;
  final double scale;
  final double zIndex;
  final double speed;
  final Color color;

  static const back = Layer2(
    spread: 1.3,
    scale: 0.7,
    zIndex: 500,
    speed: 0.4,
    color: Color(0x33ff0000),
  );
  static const middle = Layer2(
    spread: 0.75,
    scale: 1,
    zIndex: 0,
    speed: 0.5,
    color: Color(0x3300ff00),
  );
  static const front = Layer2(
    spread: 0.25,
    scale: 1,
    zIndex: -500,
    speed: 0.45,
    color: Color(0x330000ff),
  );
}

void main() {
  int i = 1;
  CardKey _newKey() => CardKey(i++);

  runApp(AppContainer(
    child: MontageController(
      builders: <MontageCardBuilder>[
        MontageCardBuilder(
            x: 0.00, y: 0.55, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.55, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.00, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.20, y: 0.05, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.60, y: 0.09, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.05, y: 0.15, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.80, y: 0.20, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.35, y: 0.25, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.64, y: 0.30, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.25, y: 0.35, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.85, y: 0.40, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.10, y: 0.45, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.85, y: 0.49, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.40, y: 0.50, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.60, y: 0.55, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.15, y: 0.60, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.65, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.65, y: 0.66, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.20, y: 0.70, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.45, y: 0.75, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.75, y: 0.80, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.09, y: 0.85, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.88, y: 0.89, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.50, y: 0.90, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.25, y: 0.95, layer: Layer2.back, key: _newKey()),
        MontageCardBuilder(
            x: 0.04, y: 0.05, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.40, y: 0.10, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.96, y: 0.15, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.24, y: 0.20, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.80, y: 0.25, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.10, y: 0.30, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.70, y: 0.35, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.40, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.10, y: 0.42, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.67, y: 0.48, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.22, y: 0.55, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.84, y: 0.60, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.15, y: 0.65, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.74, y: 0.70, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.10, y: 0.75, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.88, y: 0.80, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.35, y: 0.85, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.03, y: 0.92, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.85, y: 0.95, layer: Layer2.middle, key: _newKey()),
        MontageCardBuilder(
            x: 0.00, y: 0.25, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.35, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 0.50, y: 0.45, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 1.00, y: 0.55, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 0.00, y: 0.65, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 0.50, y: 0.80, layer: Layer2.front, key: _newKey()),
        MontageCardBuilder(
            x: 0.00, y: 1.00, layer: Layer2.front, key: _newKey()),
      ],
    ),
  ));
}

class CardKey extends ValueKey<int> {
  const CardKey(super.value);
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.fromWindow(child: child);
  }
}

class MontageController extends StatefulWidget {
  const MontageController({super.key, required this.builders});

  final List<MontageCardBuilder> builders;

  @override
  State<MontageController> createState() => _MontageControllerState();
}

class _MontageControllerState extends State<MontageController> {
  final Map<CardKey, Offset> _locations = <CardKey, Offset>{};
  final Map<CardKey, Widget> _content = <CardKey, Widget>{};
  late int _scheduledFrameCallbackId;
  late Size _screenSize;
  int _currentFrame = 0;

  void _scheduleFrame({bool rescheduling = false}) {
    _scheduledFrameCallbackId = SchedulerBinding.instance.scheduleFrameCallback(
      _onFrame,
      rescheduling: rescheduling,
    );
  }

  void _onFrame(Duration timeStamp) {
    setState(() => _currentFrame++);
    _scheduleFrame(rescheduling: true);
  }

  @override
  void initState() {
    super.initState();
    _scheduleFrame();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    SchedulerBinding.instance
        .cancelFrameCallbackWithId(_scheduledFrameCallbackId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<MontageCard> children = <MontageCard>[];
    for (MontageCardBuilder builder in widget.builders) {
      Offset location = builder.calculateLocation(_currentFrame, _screenSize);
      Offset? lastLocation = _locations[builder.key];
      Widget? content = _content[builder.key];
      assert(content == null || lastLocation != null);
      if (lastLocation == null || lastLocation.dy < location.dy) {
        _content[builder.key] = content = ProducerNamespace.produce(context);
      }
      _locations[builder.key] = location;

      Widget child = content!;
      assert(() {
        if (_debugExtraInfo) {
          child = Stack(
            fit: StackFit.passthrough,
            textDirection: TextDirection.ltr,
            children: [
              child,
              ColoredBox(color: builder.layer.color),
              Text(
                builder.key.toString(),
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffcc0000),
                ),
              ),
            ],
          );
        }
        return true;
      }());

      MontageCard card = MontageCard(
        key: builder.key,
        x: location.dx,
        y: location.dy,
        z: builder.layer.zIndex,
        scale: builder.layer.scale,
        child: child,
      );
      children.add(card);
    }
    return MontageSpinner(
      key: widget.key,
      children: children,
    );
  }
}

typedef ContentProducer = Widget Function(BuildContext context);

class ProducerNamespace {
  static int index = 0;

  static Widget produce(BuildContext context) {
    Widget result = Image(image: images[index]);
    index = (index + 1) % images.length;
    return result;
  }
}

class MontageCardBuilder {
  const MontageCardBuilder({
    required this.key,
    required this.x,
    required this.y,
    required this.layer,
  });

  final CardKey key;
  final double x;
  final double y;
  final Layer2 layer;

  static const _canvasScreenRatio = 7;

  double _calculateDx(Size screenSize) {
    return screenSize.width * x * layer.spread;
  }

  double _calculateDy(Size screenSize, int currentFrame) {
    double canvasHeight = screenSize.height * _canvasScreenRatio;
    double yOffset = canvasHeight * y;
    double frameOffset =
        canvasHeight - ((currentFrame * layer.speed) % canvasHeight);
    double yPos = (frameOffset + yOffset) % canvasHeight;
    double viewportOffset = (canvasHeight - screenSize.height) / -2;
    return yPos + viewportOffset;
  }

  Offset calculateLocation(int currentFrame, Size screenSize) {
    return Offset(
      _calculateDx(screenSize),
      _calculateDy(screenSize, currentFrame),
    );
  }
}

class MontageSpinner extends StatefulWidget {
  const MontageSpinner({
    super.key,
    this.children = const <MontageCard>[],
  });

  final List<MontageCard> children;

  @override
  State<MontageSpinner> createState() => _MontageSpinnerState();
}

class _MontageSpinnerState extends State<MontageSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> rotation;
  late Animation<double> distance;

  static const double _maxDistance = 800;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() {
        setState(() {
          // Updated animation values will be reflected in `build()`
        });
      });
    rotation = ThetaTween()
        .chain(CurveTween(curve: Curves.easeInOutCubic))
        .animate(animation);
    distance = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: _maxDistance)
              .chain(CurveTween(curve: Curves.easeInOutSine)),
          weight: 48,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(_maxDistance),
          weight: 4,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: _maxDistance, end: 0)
              .chain(CurveTween(curve: Curves.easeInOutSine)),
          weight: 48,
        ),
      ],
    ).animate(animation);

    Timer.periodic(_rotationInterval, (Timer timer) {
      animation.forward(from: 0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Montage(
      rotation: rotation.value,
      distance: distance.value,
      children: widget.children,
    );
  }
}

class ThetaTween extends Tween<double> {
  ThetaTween() : super(begin: 0, end: _fullRotation);

  static const _fullRotation = -2 * math.pi;

  @override
  double lerp(double t) => ui.lerpDouble(0, _fullRotation, t)!;
}

class Montage extends MultiChildRenderObjectWidget {
  Montage({
    super.key,
    this.rotation = 0,
    this.distance = 0,
    List<MontageCard> super.children = const <MontageCard>[],
  });

  final double rotation;
  final double distance;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderMontage(
        rotation: rotation,
        distance: distance,
      );

  @override
  void updateRenderObject(BuildContext context, RenderMontage renderObject) {
    renderObject.rotation = rotation;
    renderObject.distance = distance;
  }
}

class MontageParentData extends ContainerBoxParentData<RenderBox> {}

class RenderMontage extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MontageParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MontageParentData> {
  RenderMontage({
    double rotation = 0,
    double distance = 0,
  })  : _rotation = rotation,
        _distance = distance;

  static final Matrix4 _perspectiveTransform = Matrix4(
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.001,
    0.0,
    0.0,
    0.0,
    1.0,
  );

  double _rotation = 0;
  double get rotation => _rotation;
  set rotation(double value) {
    if (_rotation != value) {
      assert(rotation <= math.pi * 2 && rotation >= -math.pi * 2);
      _rotation = value;
      markNeedsPaint();
    }
  }

  double _distance = 0;
  double get distance => _distance;
  set distance(double value) {
    if (_distance != value) {
      _distance = value;
      markNeedsPaint();
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! MontageParentData) {
      child.parentData = MontageParentData();
    }
  }

  @override
  void performLayout() {
    assert(constraints.isTight);
    final double maxSize =
        math.max(constraints.maxWidth, constraints.maxHeight);
    final Constraints childConstraints =
        BoxConstraints.tight(Size.square(maxSize * 0.25));
    RenderBox? child = firstChild;
    while (child != null) {
      MontageParentData childParentData = child.parentData as MontageParentData;
      child.layout(childConstraints);
      child = childParentData.nextSibling;
    }
    size = constraints.biggest;
  }

  void paintBackwards(PaintingContext context, Offset offset) {
    RenderBox? child = lastChild;
    while (child != null) {
      final MontageParentData childParentData =
          child.parentData! as MontageParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.previousSibling;
    }
  }

  void paintForwards(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    assert(() {
      if (_debugExtraInfo) {
        Paint paint = Paint()..color = const Color(0xffffffff);
        context.canvas.drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          paint,
        );
      }
      return true;
    }());
    while (child != null) {
      final MontageParentData childParentData =
          child.parentData! as MontageParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final double distanceDx = math.tan(perspectiveAngleRadians) * distance;
    final double centerDx = size.width / 2;
    assert(() {
      if (_debugExtraInfo) {
        Paint paint = Paint()..color = const Color(0xffcc0000);
        context.canvas.drawLine(
          Offset(centerDx, 0),
          Offset(centerDx, size.height),
          paint,
        );
      }
      return true;
    }());
    Matrix4 transform = _perspectiveTransform.clone()
      ..translate(centerDx + distanceDx, 0.0, distance)
      ..rotateY(rotation)
      ..translate(-centerDx);
    PaintingContextCallback painter = paintForwards;
    if (rotation.abs() >= math.pi / 2.85 && rotation.abs() < math.pi * 1.48) {
      painter = paintBackwards;
    }
    layer = context.pushTransform(
      needsCompositing,
      offset,
      transform,
      painter,
      oldLayer: layer as TransformLayer?,
    );
  }
}

class MontageCard extends SingleChildRenderObjectWidget {
  const MontageCard({
    super.key,
    this.x = 0,
    this.y = 0,
    this.z = 0,
    this.scale = 1,
    super.child,
  });

  final double x;
  final double y;
  final double z;
  final double scale;

  // MontageCard moveBy({double? x, double? y, double? z}) {
  //   return MontageCard(
  //     x: x ?? this.x,
  //     y: y ?? this.y,
  //     z: z ?? this.z,
  //     scale: scale,
  //     child: child,
  //   );
  // }

  @override
  RenderMontageCard createRenderObject(BuildContext context) {
    return RenderMontageCard(
      x: x,
      y: y,
      z: z,
      scale: scale,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMontageCard renderObject) {
    renderObject
      ..x = x
      ..y = y
      ..z = z
      ..scale = scale;
  }
}

class RenderMontageCard extends RenderProxyBox {
  RenderMontageCard({
    double x = 0,
    double y = 0,
    double z = 0,
    double scale = 0,
  })  : _x = x,
        _y = y,
        _z = z,
        _scale = scale;

  double _x = 0;
  double get x => _x;
  set x(double value) {
    if (value != _x) {
      _x = value;
      markNeedsPaint();
    }
  }

  double _y = 0;
  double get y => _y;
  set y(double value) {
    if (value != _y) {
      _y = value;
      markNeedsPaint();
    }
  }

  double _z = 0;
  double get z => _z;
  set z(double value) {
    if (value != _z) {
      _z = value;
      markNeedsPaint();
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

  Matrix4 get transform {
    return Matrix4.identity()
      ..translate(x, y, z)
      ..scale(scale, scale, scale);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    layer = context.pushTransform(
      needsCompositing,
      offset,
      transform,
      super.paint,
      oldLayer: layer as TransformLayer?,
    );
  }
}
