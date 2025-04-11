package platform.client.fp10.core.service.loadingprogress {
  public interface ILoadingProgressService {
    function addPacketListener(param1:ILoadingProgressListener) : void;
    function removePacketListener(param1:ILoadingProgressListener) : void;
  }
}
