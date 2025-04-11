package org.swiftsuspenders.injectionpoints {
  import flash.utils.getQualifiedClassName;
  import org.swiftsuspenders.InjectionConfig;
  import org.swiftsuspenders.Injector;
  import org.swiftsuspenders.InjectorError;

  public class MethodInjectionPoint extends InjectionPoint {
    protected var methodName:String;
    protected var _parameterInjectionConfigs:Array;
    protected var requiredParameters:int = 0;

    public function MethodInjectionPoint(node:XML, injector:Injector = null) {
      super(node,injector);
    }

    override public function applyInjection(target:Object, injector:Injector) : Object {
      var parameters:Array = this.gatherParameterValues(target,injector);
      var method:Function = target[this.methodName];
      method.apply(target,parameters);
      return target;
    }

    override protected function initializeInjection(node:XML) : void {
      var nameArgs:XMLList = null;
      var methodNode:XML = null;
      nameArgs = node.arg.(@key == "name");
      methodNode = node.parent();
      this.methodName = methodNode.@name.toString();
      this.gatherParameters(methodNode,nameArgs);
    }

    protected function gatherParameters(methodNode:XML, nameArgs:XMLList) : void {
      var parameter:XML = null;
      var injectionName:String = null;
      var parameterTypeName:String = null;
      this._parameterInjectionConfigs = [];
      var i:int = 0;
      for each(parameter in methodNode.parameter) {
        injectionName = "";
        if(Boolean(nameArgs[i])) {
          injectionName = nameArgs[i].@value.toString();
        }
        parameterTypeName = parameter.@type.toString();
        if(parameterTypeName == "*") {
          if(parameter.@optional.toString() == "false") {
            throw new InjectorError("Error in method definition of injectee. " + "Required parameters can\'t have type \"*\".");
          }
          parameterTypeName = null;
        }
        this._parameterInjectionConfigs.push(new ParameterInjectionConfig(parameterTypeName,injectionName));
        if(parameter.@optional.toString() == "false") {
          ++this.requiredParameters;
        }
        i++;
      }
    }

    protected function gatherParameterValues(target:Object, injector:Injector) : Array {
      var parameterConfig:ParameterInjectionConfig = null;
      var config:InjectionConfig = null;
      var injection:Object = null;
      var parameters:Array = [];
      var length:int = int(this._parameterInjectionConfigs.length);
      for(var i:int = 0; i < length; i++) {
        parameterConfig = this._parameterInjectionConfigs[i];
        config = injector.getMapping(Class(injector.getApplicationDomain().getDefinition(parameterConfig.typeName)),parameterConfig.injectionName);
        injection = config.getResponse(injector);
        if(injection == null) {
          if(i >= this.requiredParameters) {
            break;
          }
          throw new InjectorError("Injector is missing a rule to handle injection into target " + target + ". Target dependency: " + getQualifiedClassName(config.request) + ", method: " + this.methodName + ", parameter: " + (i + 1));
        }
        parameters[i] = injection;
      }
      return parameters;
    }
  }
}

final class ParameterInjectionConfig {
  public var typeName:String;
  public var injectionName:String;

  public function ParameterInjectionConfig(typeName:String, injectionName:String) {
    super();
    this.typeName = typeName;
    this.injectionName = injectionName;
  }
}
