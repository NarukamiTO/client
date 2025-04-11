package platform.client.fp10.core.service.loadingprogress {
  public interface ILoadingProgressListener {
    function onLoadingStart() : void;
    function onLoadingStop() : void;
    function onLoadingProgress(param1:int, param2:int) : void;
  }
}
