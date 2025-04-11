package fl.managers {
  import fl.core.UIComponent;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;
  import flash.utils.getQualifiedSuperclassName;

  public class StyleManager {
    private static var _instance:StyleManager;

    private var classToInstancesDict:Dictionary;
    private var globalStyles:Object;
    private var styleToClassesHash:Object;
    private var classToStylesDict:Dictionary;
    private var classToDefaultStylesDict:Dictionary;

    public function StyleManager() {
      super();
      styleToClassesHash = {};
      classToInstancesDict = new Dictionary(true);
      classToStylesDict = new Dictionary(true);
      classToDefaultStylesDict = new Dictionary(true);
      globalStyles = UIComponent.getStyleDefinition();
    }

    public static function clearComponentStyle(param1:Object, param2:String) : void {
      var local3:Class = getClassDef(param1);
      var local4:Object = getInstance().classToStylesDict[local3];
      if(local4 != null && local4[param2] != null) {
        delete local4[param2];
        invalidateComponentStyle(local3,param2);
      }
    }

    private static function getClassDef(param1:Object) : Class {
      var component:Object = param1;
      if(component is Class) {
        return component as Class;
      }
      try {
        return getDefinitionByName(getQualifiedClassName(component)) as Class;
      }
      catch(e:Error) {
        if(component is UIComponent) {
          try {
            return component.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(component)) as Class;
          }
          catch(e:Error) {
          }
        }
      }
      return null;
    }

    public static function clearStyle(param1:String) : void {
      setStyle(param1,null);
    }

    public static function setComponentStyle(param1:Object, param2:String, param3:Object) : void {
      var local4:Class = getClassDef(param1);
      var local5:Object = getInstance().classToStylesDict[local4];
      if(local5 == null) {
        local5 = getInstance().classToStylesDict[local4] = {};
      }
      if(local5 == param3) {
        return;
      }
      local5[param2] = param3;
      invalidateComponentStyle(local4,param2);
    }

    private static function setSharedStyles(param1:UIComponent) : void {
      var local5:String = null;
      var local2:StyleManager = getInstance();
      var local3:Class = getClassDef(param1);
      var local4:Object = local2.classToDefaultStylesDict[local3];
      for(local5 in local4) {
        param1.setSharedStyle(local5,getSharedStyle(param1,local5));
      }
    }

    public static function getComponentStyle(param1:Object, param2:String) : Object {
      var local3:Class = getClassDef(param1);
      var local4:Object = getInstance().classToStylesDict[local3];
      return local4 == null ? null : local4[param2];
    }

    private static function getInstance() : * {
      if(_instance == null) {
        _instance = new StyleManager();
      }
      return _instance;
    }

    private static function invalidateComponentStyle(param1:Class, param2:String) : void {
      var local4:Object = null;
      var local5:UIComponent = null;
      var local3:Dictionary = getInstance().classToInstancesDict[param1];
      if(local3 == null) {
        return;
      }
      for(local4 in local3) {
        local5 = local4 as UIComponent;
        if(local5 != null) {
          local5.setSharedStyle(param2,getSharedStyle(local5,param2));
        }
      }
    }

    private static function invalidateStyle(param1:String) : void {
      var local3:Object = null;
      var local2:Dictionary = getInstance().styleToClassesHash[param1];
      if(local2 == null) {
        return;
      }
      for(local3 in local2) {
        invalidateComponentStyle(Class(local3),param1);
      }
    }

    public static function registerInstance(param1:UIComponent) : void {
      var target:Class = null;
      var defaultStyles:Object = null;
      var styleToClasses:Object = null;
      var n:String = null;
      var instance:UIComponent = param1;
      var inst:StyleManager = getInstance();
      var classDef:Class = getClassDef(instance);
      if(classDef == null) {
        return;
      }
      if(inst.classToInstancesDict[classDef] == null) {
        inst.classToInstancesDict[classDef] = new Dictionary(true);
        target = classDef;
        while(defaultStyles == null) {
          if(target["getStyleDefinition"] != null) {
            defaultStyles = target["getStyleDefinition"]();
            break;
          }
          try {
            target = instance.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(target)) as Class;
          }
          catch(err:Error) {
            try {
              target = getDefinitionByName(getQualifiedSuperclassName(target)) as Class;
            }
            catch(e:Error) {
              defaultStyles = UIComponent.getStyleDefinition();
              break;
            }
          }
        }
        styleToClasses = inst.styleToClassesHash;
        for(n in defaultStyles) {
          if(styleToClasses[n] == null) {
            styleToClasses[n] = new Dictionary(true);
          }
          styleToClasses[n][classDef] = true;
        }
        inst.classToDefaultStylesDict[classDef] = defaultStyles;
        if(inst.classToStylesDict[classDef] == null) {
          inst.classToStylesDict[classDef] = {};
        }
      }
      inst.classToInstancesDict[classDef][instance] = true;
      setSharedStyles(instance);
    }

    public static function getStyle(param1:String) : Object {
      return getInstance().globalStyles[param1];
    }

    private static function getSharedStyle(param1:UIComponent, param2:String) : Object {
      var local3:Class = getClassDef(param1);
      var local4:StyleManager = getInstance();
      var local5:Object = local4.classToStylesDict[local3][param2];
      if(local5 != null) {
        return local5;
      }
      local5 = local4.globalStyles[param2];
      if(local5 != null) {
        return local5;
      }
      return local4.classToDefaultStylesDict[local3][param2];
    }

    public static function setStyle(param1:String, param2:Object) : void {
      var local3:Object = getInstance().globalStyles;
      if(local3[param1] === param2 && !(param2 is TextFormat)) {
        return;
      }
      local3[param1] = param2;
      invalidateStyle(param1);
    }
  }
}
