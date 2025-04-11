package {
  import adobe.utils.*;
  import fl.controls.Slider;
  import flash.accessibility.*;
  import flash.desktop.*;
  import flash.display.*;
  import flash.errors.*;
  import flash.events.*;
  import flash.external.*;
  import flash.filters.*;
  import flash.geom.*;
  import flash.globalization.*;
  import flash.media.*;
  import flash.net.*;
  import flash.net.drm.*;
  import flash.printing.*;
  import flash.profiler.*;
  import flash.sampler.*;
  import flash.sensors.*;
  import flash.system.*;
  import flash.text.*;
  import flash.text.engine.*;
  import flash.text.ime.*;
  import flash.ui.*;
  import flash.utils.*;
  import flash.xml.*;

  [Embed(source="/_assets/assets.swf", symbol="symbol1209")]
  public dynamic class tankGUI extends MovieClip {
    public var __id4_:Slider;

    public function tankGUI() {
      super();
      this.__setProp___id4__tankGUI_Controls_0();
    }

    internal function __setProp___id4__tankGUI_Controls_0() : * {
      try {
        this.__id4_["componentInspectorSetting"] = true;
      }
      catch(e:Error) {
      }
      this.__id4_.direction = "vertical";
      this.__id4_.enabled = true;
      this.__id4_.liveDragging = true;
      this.__id4_.maximum = 10;
      this.__id4_.minimum = 0;
      this.__id4_.snapInterval = 0;
      this.__id4_.tickInterval = 1;
      this.__id4_.value = 0;
      this.__id4_.visible = true;
      try {
        this.__id4_["componentInspectorSetting"] = false;
      }
      catch(e:Error) {
      }
    }
  }
}
