package fl.livepreview {
  import flash.display.*;
  import flash.external.*;
  import flash.utils.*;

  public class LivePreviewParent extends MovieClip {
    public var myInstance:DisplayObject;

    public function LivePreviewParent() {
      super();
      try {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        myInstance = getChildAt(0);
        onResize(stage.width,stage.height);
        if(ExternalInterface.available) {
          ExternalInterface.addCallback("onResize",onResize);
          ExternalInterface.addCallback("onUpdate",onUpdate);
        }
      }
      catch(e:*) {
      }
    }

    public function onUpdate(... rest) : void {
      var name:String = null;
      var value:* = undefined;
      var updateArray:Array = rest;
      var i:int = 0;
      while(i + 1 < updateArray.length) {
        try {
          name = String(updateArray[i]);
          value = updateArray[i + 1];
          if(typeof value == "object" && Boolean(value.__treatAsCollectionSpecialSauce__)) {
            updateCollection(value,name);
          } else {
            myInstance[name] = value;
          }
        }
        catch(e:Error) {
        }
        i += 2;
      }
    }

    public function onResize(param1:Number, param2:Number) : void {
      var width:Number = param1;
      var height:Number = param2;
      var setSizeFn:Function = null;
      try {
        setSizeFn = myInstance["setSize"];
      }
      catch(e:Error) {
        setSizeFn = null;
      }
      if(setSizeFn != null) {
        setSizeFn(width,height);
      } else {
        myInstance.width = width;
        myInstance.height = height;
      }
    }

    private function updateCollection(param1:Object, param2:String) : void {
      var local7:Object = null;
      var local8:Object = null;
      var local9:* = undefined;
      var local3:Class = Class(getDefinitionByName(param1.collectionClass));
      var local4:Class = Class(getDefinitionByName(param1.collectionItemClass));
      var local5:Object = new local3();
      var local6:int = 0;
      while(local6 < param1.collectionArray.length) {
        local7 = new local4();
        local8 = param1.collectionArray[local6];
        for(local9 in local8) {
          local7[local9] = local8[local9];
        }
        local5.addItem(local7);
        local6++;
      }
      myInstance[param2] = local5 as local3;
    }
  }
}
