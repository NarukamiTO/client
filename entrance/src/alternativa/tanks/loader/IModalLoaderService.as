package alternativa.tanks.loader {
  public interface IModalLoaderService {
    function show() : void;
    function hideForcibly() : void;
    function isVisible() : Boolean;
  }
}
