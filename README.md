# flutter_bloc_and_cubit

✅ Bloc Summary

BlocProvider:
BlocProvider (using either .create or .value) provides a BLoC instance to all its descendants in the widget tree, including navigated screens, if the provider is placed above MaterialApp. Widgets like BlocBuilder, BlocListener, or any other consumer can access this instance via BuildContext. When a BlocProvider supplies a BLoC instance, any child widget in the subtree that listens to state changes (BlocBuilder, BlocListener, BlocConsumer) will receive state updates. This means that if any child modifies the BLoC’s state, all other listeners (including the one that triggered the change) and the parent (if it's a listener) will be notified with the updated state — as long as they are accessing the same instance.


BlocProvider.create:
BlocProvider.create always creates a new instance of the BLoC. It does not reuse or inherit any BLoC instance from its parent. It also automatically disposes the BLoC when the widget is removed from the tree. If the widget using .create is rebuilt or recreated (due to setState, navigation, or configuration changes), a fresh instance is created, and the initial state is emitted again.


BlocProvider.value:
Use BlocProvider.value when you already have a BLoC instance that should be passed down the widget tree. This is useful when the instance is created outside the build method, making it available throughout the class. It can also be fetched through a constructor from a parent widget or through context in lifecycle methods like didChangeDependencies(). The .value constructor does not manage disposal, so need to dispose of the instance manually where it was created. If a child widget disposes of the instance, it can lead to crashes for other consumers (such as parents or siblings) that rely on the same instance.
The BlocProvider.value constructor should ideally be used only once, and only when the BLoC instance is created outside the build() method—such as in the initState or passed down via constructor—and needs to be passed further down the tree. Overusing it or unnecessarily wrapping widgets again leads to resource overhead and increases the risk of untracked disposal, which can cause runtime crashes. For example, in navigation scenarios or within child widgets, re-providing an already available BLoC instance using value (especially multiple times) is discouraged. This becomes dangerous when using navigation methods like pushReplacement or pushAndRemoveUntil, which may dispose of the original widget (and its BLoC instance), while the new screen still tries to access that disposed instance, causing unexpected behavior or crashes.


BlocBuilder:
BlocBuilder is responsible for rebuilding the UI in response to new states. It listens to the BLoC and calls its builder function whenever the state changes. However, if the previous and current state are considered equal (using ==), it won’t rebuild. You can control this further using the buildWhen callback, which only rebuilds when buildWhen(previous, current) returns true.


BlocListener :
BlocListener is used for one-time side effects such as showing dialogs, snackbars, or navigation. It listens for state changes and executes its listener only when the state actually changes (new instance and not equal to previous). Similar to builder, it supports listenWhen to control which states trigger the listener logic. Note: after a hot reload, builder re-executes but listener does not unless a new state is emitted.


BlocConsumer:
BlocConsumer combines the functionality of both BlocBuilder and BlocListener. It gives full control over UI rebuilds and side-effect execution using both buildWhen and listenWhen. Both the builder and listener are called only if their respective conditions return true and the state is a new instance.

Scenario	State Type & Value Change	                              	Consumer(Builder+Listener)
1️⃣	state(0) → state(0) (Same instance & same value)		❌ No
2️⃣	State(0) → State(0) (New instance, same value)			✅ Yes
3️⃣	State(0) → State(1) (Same type, value changed)			✅ Yes
4️⃣	StateA(0) → StateB(0) (Different type, same value)		✅ Yes
5️⃣	StateA(0) → StateB(1) (Different type & value)			✅ Yes

Scenario	emit(...) call					Same instance?	Same value?	Will emit?	Why?
emit(state)							✅ Yes			✅ Yes		❌ No		Bloc sees no change → same reference
emit(State(state.value))					❌ No			✅ Yes		✅ Yes		Bloc sees change → new object

🔄 State Emission Behavior Rule:
"State emission occurs only when the state is a new instance, even if the state values are identical to the previous state. This is because BLoC checks the object reference to determine whether the state has changed. If the same instance is emitted (even with the same value), it is treated as the same state, and no emission or rebuild will occur. Emitting a new instance, regardless of the values, ensures that the state is recognized as changed and triggers necessary rebuilds and listeners."


BlocSelector:
BlocSelector is used to optimize rebuilds by selecting only a specific part of the BLoC state. It rebuilds only when the selected value changes (based on ==). It doesn’t rebuild if the selected value remains the same—even if the entire state object changes. This is useful for performance when only a portion of the state is relevant to a widget. However, all states that are expected to be handled by the selector must carry the required value. If not, you should safely switch over the state type and return a fallback to avoid runtime errors.

Scenario	State Type & Value Change	                              			Selector
1️⃣		state(0) → state(0) (Same instance & same value)		❌ No
2️⃣		State(0) → State(0) (New instance, same value)			❌ No
3️⃣		State(0) → State(1) (Same type, value changed)			✅ Yes
4️⃣		StateA(0) → StateB(0) (Different type, same value)		❌ No (⚠️ Only if selector uses type check)
5️⃣		StateA(0) → StateB(1) (Different type & value)			✅ Yes

🔄 BlocSelector Emission Behavior Rule:
"BlocSelector triggers rebuilds only when the selected portion of the state changes. If the selected value from the state is the same (even if the state object is a new instance), the rebuild will not occur. This behavior ensures efficiency by reducing unnecessary UI updates. If you want the selector to detect changes in the state or the selected value, it is important to ensure the selector's value changes (or the state object is new) to trigger the rebuild."

In BLoC (and Cubit), the behavior is primarily dependent on the state, not the event.
The UI in BlocBuilder, BlocConsumer, and BlocListener reacts to state changes, not the events. These widgets rebuild the UI whenever the state changes or when specific logic is triggered.
In BlocSelector, it listens for changes in a selected portion of the state and rebuilds the UI only if that selected value changes.

Cubit and BLoC follow the same rules about rebuilding the UI based on state changes.

1. Event-Driven vs State-Driven:
   In BLoC, you dispatch events, and the BLoC processes these events to emit new states.
   In Cubit, there are no events—Cubit directly emits states. You call methods on the Cubit to emit new states.

Key Point: Both Cubit and BLoC are state-driven. The UI listens for changes in the state, not the event/cubit method itself.

