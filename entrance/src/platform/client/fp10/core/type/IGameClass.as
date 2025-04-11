package platform.client.fp10.core.type {
  import alternativa.types.Long;

  public interface IGameClass {
    function get id() : Long;
    function get models() : Vector.<Long>;
  }
}
