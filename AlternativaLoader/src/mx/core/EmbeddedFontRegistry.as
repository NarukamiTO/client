package mx.core {
  import flash.system.Capabilities;
  import flash.text.FontStyle;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.engine.FontDescription;
  import flash.utils.Dictionary;
  import flash.utils.getQualifiedClassName;
  import mx.managers.ISystemManager;
  import mx.resources.IResourceManager;
  import mx.resources.ResourceManager;

  use namespace mx_internal;

  public class EmbeddedFontRegistry implements IEmbeddedFontRegistry {
    private static var instance:IEmbeddedFontRegistry;

    mx_internal static const VERSION:String = "4.6.0.23201";

    private static var fonts:Object = {};
    private static var cachedFontsForObjects:Dictionary = new Dictionary(true);
    private static var staticTextFormat:TextFormat = new TextFormat();
    private static var flaggedObjects:Dictionary = new Dictionary(true);

    private var _resourceManager:IResourceManager;

    public function EmbeddedFontRegistry() {
      super();
    }

    public static function getInstance() : IEmbeddedFontRegistry {
      if(!instance) {
        instance = new EmbeddedFontRegistry();
      }
      return instance;
    }

    private static function createFontKey(param1:EmbeddedFont) : String {
      return param1.fontName + param1.fontStyle;
    }

    private static function createEmbeddedFont(param1:String) : EmbeddedFont {
      var local2:String = null;
      var local3:Boolean = false;
      var local4:Boolean = false;
      var local5:int = endsWith(param1,FontStyle.REGULAR);
      if(local5 > 0) {
        local2 = param1.substring(0,local5);
        return new EmbeddedFont(local2,false,false);
      }
      local5 = endsWith(param1,FontStyle.BOLD);
      if(local5 > 0) {
        local2 = param1.substring(0,local5);
        return new EmbeddedFont(local2,true,false);
      }
      local5 = endsWith(param1,FontStyle.BOLD_ITALIC);
      if(local5 > 0) {
        local2 = param1.substring(0,local5);
        return new EmbeddedFont(local2,true,true);
      }
      local5 = endsWith(param1,FontStyle.ITALIC);
      if(local5 > 0) {
        local2 = param1.substring(0,local5);
        return new EmbeddedFont(local2,false,true);
      }
      return new EmbeddedFont("",false,false);
    }

    private static function endsWith(param1:String, param2:String) : int {
      var local3:int = int(param1.lastIndexOf(param2));
      if(local3 > 0 && local3 + param2.length == param1.length) {
        return local3;
      }
      return -1;
    }

    public static function registerFonts(param1:Object, param2:IFlexModuleFactory) : void {
      var fontRegistry:IEmbeddedFontRegistry = null;
      var f:Object = null;
      var fontObj:Object = null;
      var fieldIter:String = null;
      var bold:Boolean = false;
      var italic:Boolean = false;
      var fonts:Object = param1;
      var moduleFactory:IFlexModuleFactory = param2;
      try {
        fontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
      }
      catch(e:Error) {
        Singleton.registerClass("mx.core::IEmbeddedFontRegistry",EmbeddedFontRegistry);
        fontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
      }
      for(f in fonts) {
        fontObj = fonts[f];
        for(fieldIter in fontObj) {
          if(fontObj[fieldIter] != false) {
            if(fieldIter == "regular") {
              bold = false;
              italic = false;
            } else if(fieldIter == "boldItalic") {
              bold = true;
              italic = true;
            } else if(fieldIter == "bold") {
              bold = true;
              italic = false;
            } else if(fieldIter == "italic") {
              bold = false;
              italic = true;
            }
            fontRegistry.registerFont(new EmbeddedFont(String(f),bold,italic),moduleFactory);
          }
        }
      }
    }

    private function get resourceManager() : IResourceManager {
      if(!this._resourceManager) {
        this._resourceManager = ResourceManager.getInstance();
      }
      return this._resourceManager;
    }

    public function getFontStyle(param1:Boolean, param2:Boolean) : String {
      var local3:String = FontStyle.REGULAR;
      if(param1 && param2) {
        local3 = FontStyle.BOLD_ITALIC;
      } else if(param1) {
        local3 = FontStyle.BOLD;
      } else if(param2) {
        local3 = FontStyle.ITALIC;
      }
      return local3;
    }

    public function registerFont(param1:EmbeddedFont, param2:IFlexModuleFactory) : void {
      var local3:String = createFontKey(param1);
      var local4:Dictionary = fonts[local3];
      if(!local4) {
        local4 = new Dictionary(true);
        fonts[local3] = local4;
      }
      local4[param2] = 1;
    }

    public function deregisterFont(param1:EmbeddedFont, param2:IFlexModuleFactory) : void {
      var local5:int = 0;
      var local6:Object = null;
      var local3:String = createFontKey(param1);
      var local4:Dictionary = fonts[local3];
      if(local4 != null) {
        delete local4[param2];
        local5 = 0;
        for(local6 in local4) {
          local5++;
        }
        if(local5 == 0) {
          delete fonts[local3];
        }
      }
    }

    public function isFontRegistered(param1:EmbeddedFont, param2:IFlexModuleFactory) : Boolean {
      var local3:String = createFontKey(param1);
      var local4:Dictionary = fonts[local3];
      return (Boolean(local4)) && local4[param2] == 1;
    }

    public function getFonts() : Array {
      var local2:String = null;
      var local1:Array = [];
      for(local2 in fonts) {
        local1.push(createEmbeddedFont(local2));
      }
      return local1;
    }

    public function getAssociatedModuleFactory(param1:String, param2:Boolean, param3:Boolean, param4:Object, param5:IFlexModuleFactory, param6:ISystemManager, param7:* = undefined) : IFlexModuleFactory {
      var local8:EmbeddedFont = null;
      var local9:IFlexModuleFactory = null;
      var local11:int = 0;
      var local12:Object = null;
      var local13:Boolean = false;
      var local14:String = null;
      local8 = cachedFontsForObjects[param4];
      if(!local8) {
        local8 = new EmbeddedFont(param1,param2,param3);
        cachedFontsForObjects[param4] = local8;
      } else if(local8.fontName != param1 || local8.bold != param2 || local8.italic != param3) {
        local8 = new EmbeddedFont(param1,param2,param3);
        cachedFontsForObjects[param4] = local8;
      }
      var local10:Dictionary = fonts[createFontKey(local8)];
      if(local10) {
        local11 = int(local10[param5]);
        if(local11) {
          local9 = param5;
        } else {
          var local15:int = 0;
          var local16:* = local10;
          for(local12 in local16) {
            local9 = local12 as IFlexModuleFactory;
          }
        }
      }
      if(!local9 && Boolean(param6)) {
        staticTextFormat.font = param1;
        staticTextFormat.bold = param2;
        staticTextFormat.italic = param3;
        if(param6.isFontFaceEmbedded(staticTextFormat)) {
          local9 = param6;
        }
      }
      if(local9 && param7 != undefined && Capabilities.isDebugger) {
        local13 = !!param7 ? local9.callInContext(FontDescription.isFontCompatible,null,[param1,param2 ? "bold" : "normal",param3 ? "italic" : "normal"]) : local9.callInContext(TextField.isFontCompatible,null,[param1,this.getFontStyle(param2,param3)]);
        if(!local13) {
          if(!flaggedObjects[param4]) {
            local14 = getQualifiedClassName(param4);
            local14 = local14 + ("name" in param4 && param4.name != null ? " (" + param4.name + ") " : "");
            trace(this.resourceManager.getString("core","fontIncompatible",[param1,local14,param7]));
            flaggedObjects[param4] = true;
          }
        }
      }
      return local9;
    }
  }
}
