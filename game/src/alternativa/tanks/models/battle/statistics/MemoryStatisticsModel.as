package alternativa.tanks.models.battle.statistics {
  import flash.system.System;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.statistics.IMemoryStatisticsModelBase;
  import projects.tanks.client.battlefield.models.statistics.MemoryStatisticsModelBase;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  [ModelInfo]
  public class MemoryStatisticsModel extends MemoryStatisticsModelBase implements IMemoryStatisticsModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    private var intervalId:uint;

    public function MemoryStatisticsModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      this.intervalId = setInterval(getFunctionWrapper(this.sendStatistics),5000);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      clearInterval(this.intervalId);
    }

    private function sendStatistics() : void {
      server.collect(GPUCapabilities.gpuEnabled,System.totalMemoryNumber / 1024);
    }
  }
}
