package mx.core {
  public interface ILayoutDirectionElement {
    function get layoutDirection() : String;
    function set layoutDirection(value:String) : void;
    function invalidateLayoutDirection() : void;
  }
}
