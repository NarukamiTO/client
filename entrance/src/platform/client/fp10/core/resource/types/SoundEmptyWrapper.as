package platform.client.fp10.core.resource.types {
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.media.SoundLoaderContext;
  import flash.media.SoundTransform;
  import flash.net.URLRequest;

  public class SoundEmptyWrapper extends Sound {
    public function SoundEmptyWrapper() {
      super();
    }

    override public function toString() : String {
      return "[SoundEmptyWrapper]";
    }

    override public function play(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : SoundChannel {
      return null;
    }

    override public function load(param1:URLRequest, param2:SoundLoaderContext = null) : void {
    }
  }
}
