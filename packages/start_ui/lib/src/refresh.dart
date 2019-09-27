// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//import 'dart:async';
//import 'dart:math';
//
//import 'package:flutter/rendering.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';
//
//import 'activity_indicator.dart';
//import 'colors.dart';
//import 'icons.dart';
//
//class _SliverRefresh extends SingleChildRenderObjectWidget {
//  const _SliverRefresh({
//    Key key,
//    this.refreshIndicatorLayoutExtent = 0.0,
//    this.hasLayoutExtent = false,
//    Widget child,
//  })  : assert(refreshIndicatorLayoutExtent != null),
//        assert(refreshIndicatorLayoutExtent >= 0.0),
//        assert(hasLayoutExtent != null),
//        super(key: key, child: child);
//
//  // The amount of space the indicator should occupy in the sliver in a
//  // resting state when in the refreshing mode.
//  final double refreshIndicatorLayoutExtent;
//
//  // _RenderSliverRefresh will paint the child in the available
//  // space either way but this instructs the _RenderSliverRefresh
//  // on whether to also occupy any layoutExtent space or not.
//  final bool hasLayoutExtent;
//
//  @override
//  _RenderSliverRefresh createRenderObject(BuildContext context) {
//    return _RenderSliverRefresh(
//      refreshIndicatorExtent: refreshIndicatorLayoutExtent,
//      hasLayoutExtent: hasLayoutExtent,
//    );
//  }
//
//  @override
//  void updateRenderObject(
//      BuildContext context, covariant _RenderSliverRefresh renderObject) {
//    renderObject
//      ..refreshIndicatorLayoutExtent = refreshIndicatorLayoutExtent
//      ..hasLayoutExtent = hasLayoutExtent;
//  }
//}
//
//// RenderSliver object that gives its child RenderBox object space to paint
//// in the overscrolled gap and may or may not hold that overscrolled gap
//// around the RenderBox depending on whether [layoutExtent] is set.
////
//// The [layoutExtentOffsetCompensation] field keeps internal accounting to
//// prevent scroll position jumps as the [layoutExtent] is set and unset.
//class _RenderSliverRefresh extends RenderSliver
//    with RenderObjectWithChildMixin<RenderBox> {
//  _RenderSliverRefresh({
//    @required double refreshIndicatorExtent,
//    @required bool hasLayoutExtent,
//    RenderBox child,
//  })  : assert(refreshIndicatorExtent != null),
//        assert(refreshIndicatorExtent >= 0.0),
//        assert(hasLayoutExtent != null),
//        _refreshIndicatorExtent = refreshIndicatorExtent,
//        _hasLayoutExtent = hasLayoutExtent {
//    this.child = child;
//  }
//
//  // The amount of layout space the indicator should occupy in the sliver in a
//  // resting state when in the refreshing mode.
//  double get refreshIndicatorLayoutExtent => _refreshIndicatorExtent;
//  double _refreshIndicatorExtent;
//  set refreshIndicatorLayoutExtent(double value) {
//    assert(value != null);
//    assert(value >= 0.0);
//    if (value == _refreshIndicatorExtent) return;
//    _refreshIndicatorExtent = value;
//    markNeedsLayout();
//  }
//
//  // The child box will be laid out and painted in the available space either
//  // way but this determines whether to also occupy any
//  // [SliverGeometry.layoutExtent] space or not.
//  bool get hasLayoutExtent => _hasLayoutExtent;
//  bool _hasLayoutExtent;
//  set hasLayoutExtent(bool value) {
//    assert(value != null);
//    if (value == _hasLayoutExtent) return;
//    _hasLayoutExtent = value;
//    markNeedsLayout();
//  }
//
//  // This keeps track of the previously applied scroll offsets to the scrollable
//  // so that when [refreshIndicatorLayoutExtent] or [hasLayoutExtent] changes,
//  // the appropriate delta can be applied to keep everything in the same place
//  // visually.
//  double layoutExtentOffsetCompensation = 0.0;
//
//  @override
//  void performLayout() {
//    // Only pulling to refresh from the top is currently supported.
//    assert(constraints.axisDirection == AxisDirection.down);
//    assert(constraints.growthDirection == GrowthDirection.forward);
//
//    // The new layout extent this sliver should now have.
//    final double layoutExtent =
//        (_hasLayoutExtent ? 1.0 : 0.0) * _refreshIndicatorExtent;
//    // If the new layoutExtent instructive changed, the SliverGeometry's
//    // layoutExtent will take that value (on the next performLayout run). Shift
//    // the scroll offset first so it doesn't make the scroll position suddenly jump.
//    if (layoutExtent != layoutExtentOffsetCompensation) {
//      geometry = SliverGeometry(
//        scrollOffsetCorrection: layoutExtent - layoutExtentOffsetCompensation,
//      );
//      layoutExtentOffsetCompensation = layoutExtent;
//      // Return so we don't have to do temporary accounting and adjusting the
//      // child's constraints accounting for this one transient frame using a
//      // combination of existing layout extent, new layout extent change and
//      // the overlap.
//      return;
//    }
//
//    final bool active = constraints.overlap < 0.0 || layoutExtent > 0.0;
//    final double overscrolledExtent =
//        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
//    // Layout the child giving it the space of the currently dragged overscroll
//    // which may or may not include a sliver layout extent space that it will
//    // keep after the user lets go during the refresh process.
//    child.layout(
//      constraints.asBoxConstraints(
//        maxExtent: layoutExtent
//            // Plus only the overscrolled portion immediately preceding this
//            // sliver.
//            +
//            overscrolledExtent,
//      ),
//      parentUsesSize: true,
//    );
//    if (active) {
//      geometry = SliverGeometry(
//        scrollExtent: layoutExtent,
//        paintOrigin: -overscrolledExtent - constraints.scrollOffset,
//        paintExtent: max(
//          // Check child size (which can come from overscroll) because
//          // layoutExtent may be zero. Check layoutExtent also since even
//          // with a layoutExtent, the indicator builder may decide to not
//          // build anything.
//          max(child.size.height, layoutExtent) - constraints.scrollOffset,
//          0.0,
//        ),
//        maxPaintExtent: max(
//          max(child.size.height, layoutExtent) - constraints.scrollOffset,
//          0.0,
//        ),
//        layoutExtent: max(layoutExtent - constraints.scrollOffset, 0.0),
//      );
//    } else {
//      // If we never started overscrolling, return no geometry.
//      geometry = SliverGeometry.zero;
//    }
//  }
//
//  @override
//  void paint(PaintingContext paintContext, Offset offset) {
//    if (constraints.overlap < 0.0 ||
//        constraints.scrollOffset + child.size.height > 0) {
//      paintContext.paintChild(child, offset);
//    }
//  }
//
//  // Nothing special done here because this sliver always paints its child
//  // exactly between paintOrigin and paintExtent.
//  @override
//  void applyPaintTransform(RenderObject child, Matrix4 transform) {}
//}
//
//enum RefreshIndicatorMode {
//  inactive,
//
//  drag,
//
//  armed,
//
//  refresh,
//
//  done,
//}
//
//typedef RefreshControlIndicatorBuilder = Widget Function(
//  BuildContext context,
//  RefreshIndicatorMode refreshState,
//  double pulledExtent,
//  double refreshTriggerPullDistance,
//  double refreshIndicatorExtent,
//);
//
//typedef RefreshCallback = Future<void> Function();
//
//class SliverRefreshControl extends StatefulWidget {
//  const SliverRefreshControl({
//    Key key,
//    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
//    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
//    this.builder = buildSimpleRefreshIndicator,
//    this.onRefresh,
//  })  : assert(refreshTriggerPullDistance != null),
//        assert(refreshTriggerPullDistance > 0.0),
//        assert(refreshIndicatorExtent != null),
//        assert(refreshIndicatorExtent >= 0.0),
//        assert(
//            refreshTriggerPullDistance >= refreshIndicatorExtent,
//            'The refresh indicator cannot take more space in its final state '
//            'than the amount initially created by overscrolling.'),
//        super(key: key);
//
//  final double refreshTriggerPullDistance;
//
//  final double refreshIndicatorExtent;
//
//  final RefreshControlIndicatorBuilder builder;
//
//  final RefreshCallback onRefresh;
//
//  static const double _defaultRefreshTriggerPullDistance = 100.0;
//  static const double _defaultRefreshIndicatorExtent = 60.0;
//
//  @visibleForTesting
//  static RefreshIndicatorMode state(BuildContext context) {
//    final _SliverRefreshControlState state = context
//        .ancestorStateOfType(const TypeMatcher<_SliverRefreshControlState>());
//    return state.refreshState;
//  }
//
//  static Widget buildSimpleRefreshIndicator(
//    BuildContext context,
//    RefreshIndicatorMode refreshState,
//    double pulledExtent,
//    double refreshTriggerPullDistance,
//    double refreshIndicatorExtent,
//  ) {
//    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
//    return Align(
//      alignment: Alignment.bottomCenter,
//      child: Padding(
//        padding: const EdgeInsets.only(bottom: 16.0),
//        child: refreshState == RefreshIndicatorMode.drag
//            ? Opacity(
//                opacity: opacityCurve.transform(
//                    min(pulledExtent / refreshTriggerPullDistance, 1.0)),
//                child: const Icon(
//                  Icons.down_arrow,
//                  color: Colors.inactiveGray,
//                  size: 36.0,
//                ),
//              )
//            : Opacity(
//                opacity: opacityCurve
//                    .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
//                child: const ActivityIndicator(radius: 14.0),
//              ),
//      ),
//    );
//  }
//
//  @override
//  _SliverRefreshControlState createState() => _SliverRefreshControlState();
//}
//
//class _SliverRefreshControlState extends State<SliverRefreshControl> {
//  // Reset the state from done to inactive when only this fraction of the
//  // original `refreshTriggerPullDistance` is left.
//  static const double _inactiveResetOverscrollFraction = 0.1;
//
//  RefreshIndicatorMode refreshState;
//  // [Future] returned by the widget's `onRefresh`.
//  Future<void> refreshTask;
//  // The amount of space available from the inner indicator box's perspective.
//  //
//  // The value is the sum of the sliver's layout extent and the overscroll
//  // (which partially gets transferred into the layout extent when the refresh
//  // triggers).
//  //
//  // The value of latestIndicatorBoxExtent doesn't change when the sliver scrolls
//  // away without retracting; it is independent from the sliver's scrollOffset.
//  double latestIndicatorBoxExtent = 0.0;
//  bool hasSliverLayoutExtent = false;
//
//  @override
//  void initState() {
//    super.initState();
//    refreshState = RefreshIndicatorMode.inactive;
//  }
//
//  // A state machine transition calculator. Multiple states can be transitioned
//  // through per single call.
//  RefreshIndicatorMode transitionNextState() {
//    RefreshIndicatorMode nextState;
//
//    void goToDone() {
//      nextState = RefreshIndicatorMode.done;
//      // Either schedule the RenderSliver to re-layout on the next frame
//      // when not currently in a frame or schedule it on the next frame.
//      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
//        setState(() => hasSliverLayoutExtent = false);
//      } else {
//        SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
//          setState(() => hasSliverLayoutExtent = false);
//        });
//      }
//    }
//
//    switch (refreshState) {
//      case RefreshIndicatorMode.inactive:
//        if (latestIndicatorBoxExtent <= 0) {
//          return RefreshIndicatorMode.inactive;
//        } else {
//          nextState = RefreshIndicatorMode.drag;
//        }
//        continue drag;
//      drag:
//      case RefreshIndicatorMode.drag:
//        if (latestIndicatorBoxExtent == 0) {
//          return RefreshIndicatorMode.inactive;
//        } else if (latestIndicatorBoxExtent <
//            widget.refreshTriggerPullDistance) {
//          return RefreshIndicatorMode.drag;
//        } else {
//          if (widget.onRefresh != null) {
//            HapticFeedback.mediumImpact();
//            // Call onRefresh after this frame finished since the function is
//            // user supplied and we're always here in the middle of the sliver's
//            // performLayout.
//            SchedulerBinding.instance
//                .addPostFrameCallback((Duration timestamp) {
//              refreshTask = widget.onRefresh()
//                ..whenComplete(() {
//                  if (mounted) {
//                    setState(() => refreshTask = null);
//                    // Trigger one more transition because by this time, BoxConstraint's
//                    // maxHeight might already be resting at 0 in which case no
//                    // calls to [transitionNextState] will occur anymore and the
//                    // state may be stuck in a non-inactive state.
//                    refreshState = transitionNextState();
//                  }
//                });
//              setState(() => hasSliverLayoutExtent = true);
//            });
//          }
//          return RefreshIndicatorMode.armed;
//        }
//        // Don't continue here. We can never possibly call onRefresh and
//        // progress to the next state in one [computeNextState] call.
//        break;
//      case RefreshIndicatorMode.armed:
//        if (refreshState == RefreshIndicatorMode.armed && refreshTask == null) {
//          goToDone();
//          continue done;
//        }
//
//        if (latestIndicatorBoxExtent > widget.refreshIndicatorExtent) {
//          return RefreshIndicatorMode.armed;
//        } else {
//          nextState = RefreshIndicatorMode.refresh;
//        }
//        continue refresh;
//      refresh:
//      case RefreshIndicatorMode.refresh:
//        if (refreshTask != null) {
//          return RefreshIndicatorMode.refresh;
//        } else {
//          goToDone();
//        }
//        continue done;
//      done:
//      case RefreshIndicatorMode.done:
//        // Let the transition back to inactive trigger before strictly going
//        // to 0.0 since the last bit of the animation can take some time and
//        // can feel sluggish if not going all the way back to 0.0 prevented
//        // a subsequent pull-to-refresh from starting.
//        if (latestIndicatorBoxExtent >
//            widget.refreshTriggerPullDistance *
//                _inactiveResetOverscrollFraction) {
//          return RefreshIndicatorMode.done;
//        } else {
//          nextState = RefreshIndicatorMode.inactive;
//        }
//        break;
//    }
//
//    return nextState;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _SliverRefresh(
//      refreshIndicatorLayoutExtent: widget.refreshIndicatorExtent,
//      hasLayoutExtent: hasSliverLayoutExtent,
//      // A LayoutBuilder lets the sliver's layout changes be fed back out to
//      // its owner to trigger state changes.
//      child: LayoutBuilder(
//        builder: (BuildContext context, BoxConstraints constraints) {
//          latestIndicatorBoxExtent = constraints.maxHeight;
//          refreshState = transitionNextState();
//          if (widget.builder != null && latestIndicatorBoxExtent > 0) {
//            return widget.builder(
//              context,
//              refreshState,
//              latestIndicatorBoxExtent,
//              widget.refreshTriggerPullDistance,
//              widget.refreshIndicatorExtent,
//            );
//          }
//          return Container();
//        },
//      ),
//    );
//  }
//}
