package alternativa.tanks.engine3d {
  public class CachedEntityStat {
    public var requestCount:int;
    public var releaseCount:int;
    public var createCount:int;
    public var destroyCount:int;

    public function CachedEntityStat() {
      super();
    }

    public function clear() : void {
      this.requestCount = 0;
      this.releaseCount = 0;
      this.createCount = 0;
      this.destroyCount = 0;
    }
  }
}
