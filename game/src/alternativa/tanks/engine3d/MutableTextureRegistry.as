package alternativa.tanks.engine3d {
  import flash.display.BitmapData;

  public interface MutableTextureRegistry {
    function getTexture(param1:BitmapData, param2:Boolean = true) : BitmapData;
    function addTextureChangeHandler(param1:Function) : void;
    function clear() : void;
  }
}
