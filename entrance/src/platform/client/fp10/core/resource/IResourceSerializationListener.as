package platform.client.fp10.core.resource {
  import flash.utils.ByteArray;

  public interface IResourceSerializationListener {
    function onSerializationComplete(param1:Resource, param2:ByteArray) : void;
  }
}
