class_name ScriptUtils
extends Object


static func is_method_overridden(obj: Object, method: Callable) -> bool:
	var script: Script = obj.get_script()
	return script and script.get_base_script() and script.get_script_method_list().any(func(m: Dictionary): return m[&"name"] == method.get_method())
