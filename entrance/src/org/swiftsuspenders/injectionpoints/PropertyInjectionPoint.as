package org.swiftsuspenders.injectionpoints {
  import org.swiftsuspenders.InjectionConfig;
  import org.swiftsuspenders.Injector;
  import org.swiftsuspenders.InjectorError;

  public class PropertyInjectionPoint extends InjectionPoint {
    private var _propertyName:String;
    private var _propertyType:String;
    private var _injectionName:String;

    public function PropertyInjectionPoint(node:XML, injector:Injector = null) {
      super(node,null);
    }

    override public function applyInjection(target:Object, injector:Injector) : Object {
      var injectionConfig:InjectionConfig = injector.getMapping(Class(injector.getApplicationDomain().getDefinition(this._propertyType)),this._injectionName);
      var injection:Object = injectionConfig.getResponse(injector);
      if(injection == null) {
        throw new InjectorError("Injector is missing a rule to handle injection into property \"" + this._propertyName + "\" of object \"" + target + "\". Target dependency: \"" + this._propertyType + "\", named \"" + this._injectionName + "\"");
      }
      target[this._propertyName] = injection;
      return target;
    }

    override protected function initializeInjection(node:XML) : void {
      this._propertyType = node.parent().@type.toString();
      this._propertyName = node.parent().@name.toString();
      this._injectionName = node.arg.attribute("value").toString();
    }
  }
}
