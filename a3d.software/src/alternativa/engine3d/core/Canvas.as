package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import flash.display.DisplayObject;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.geom.ColorTransform;

  use namespace alternativa3d;

  public class Canvas extends Sprite {
    alternativa3d static const defaultColorTransform:ColorTransform = new ColorTransform();
    alternativa3d static const collector:Vector.<Canvas> = new Vector.<Canvas>();

    alternativa3d static var collectorLength:int = 0;

    alternativa3d var gfx:Graphics = graphics;
    alternativa3d var modifiedGraphics:Boolean;
    alternativa3d var modifiedAlpha:Boolean;
    alternativa3d var modifiedBlendMode:Boolean;
    alternativa3d var modifiedColorTransform:Boolean;
    alternativa3d var modifiedFilters:Boolean;
    alternativa3d var _numChildren:int = 0;
    alternativa3d var numDraws:int = 0;
    alternativa3d var object:Object3D;

    public function Canvas() {
      super();
      mouseEnabled = false;
      mouseChildren = false;
    }

    alternativa3d function getChildCanvas(param1:Boolean, param2:Boolean, param3:Object3D = null, param4:Number = 1, param5:String = "normal", param6:ColorTransform = null, param7:Array = null) : Canvas {
      var local8:Canvas = null;
      var local9:DisplayObject = null;
      // FFDec bug - original code checks [_numChildren > _numDraws] before calling [getChildAt]
      while(this.alternativa3d::_numChildren > this.alternativa3d::numDraws) {
        local9 = getChildAt(this.alternativa3d::_numChildren - 1 - this.alternativa3d::numDraws);
        if(local9 is Canvas) break;
        removeChild(local9);
        --this.alternativa3d::_numChildren;
      }
      if(this.alternativa3d::_numChildren > this.alternativa3d::numDraws++) {
        local8 = local9 as Canvas;
        if(local8.alternativa3d::modifiedGraphics) {
          local8.alternativa3d::gfx.clear();
        }
        if(local8.alternativa3d::_numChildren > 0 && !param2) {
          local8.alternativa3d::remChildren(0);
        }
      } else {
        local8 = alternativa3d::collectorLength > 0 ? alternativa3d::collector[--alternativa3d::collectorLength] : new Canvas();
        addChildAt(local8,0);
        ++this.alternativa3d::_numChildren;
      }
      local8.alternativa3d::object = param3;
      local8.alternativa3d::modifiedGraphics = param1;
      if(param4 != 1) {
        local8.alpha = param4;
        local8.alternativa3d::modifiedAlpha = true;
      } else if(local8.alternativa3d::modifiedAlpha) {
        local8.alpha = 1;
        local8.alternativa3d::modifiedAlpha = false;
      }
      if(param5 != "normal") {
        local8.blendMode = param5;
        local8.alternativa3d::modifiedBlendMode = true;
      } else if(local8.alternativa3d::modifiedBlendMode) {
        local8.blendMode = "normal";
        local8.alternativa3d::modifiedBlendMode = false;
      }
      if(param6 != null) {
        param6.alphaMultiplier = param4;
        local8.transform.colorTransform = param6;
        local8.alternativa3d::modifiedColorTransform = true;
      } else if(local8.alternativa3d::modifiedColorTransform) {
        alternativa3d::defaultColorTransform.alphaMultiplier = param4;
        local8.transform.colorTransform = alternativa3d::defaultColorTransform;
        local8.alternativa3d::modifiedColorTransform = false;
      }
      if(param7 != null) {
        local8.filters = param7;
        local8.alternativa3d::modifiedFilters = true;
      } else if(local8.alternativa3d::modifiedFilters) {
        local8.filters = null;
        local8.alternativa3d::modifiedFilters = false;
      }
      return local8;
    }

    alternativa3d function remChildren(param1:int) : void {
      var local2:Canvas = null;
      while(this.alternativa3d::_numChildren > param1) {
        local2 = removeChildAt(0) as Canvas;
        if(local2 != null) {
          local2.alternativa3d::object = null;
          if(local2.alternativa3d::modifiedGraphics) {
            local2.alternativa3d::gfx.clear();
          }
          if(local2.alternativa3d::_numChildren > 0) {
            local2.alternativa3d::remChildren(0);
          }
          var local3:* = alternativa3d::collectorLength++;
          alternativa3d::collector[local3] = local2;
        }
        --this.alternativa3d::_numChildren;
      }
    }
  }
}
