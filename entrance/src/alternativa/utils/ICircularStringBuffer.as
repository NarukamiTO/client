package alternativa.utils {
  public interface ICircularStringBuffer {
    function add(param1:String) : void;
    function clear() : void;
    function get size() : int;
    function get capacity() : int;
    function set capacity(param1:int) : void;
    function getIterator(param1:int) : IStringBufferIterator;
  }
}
