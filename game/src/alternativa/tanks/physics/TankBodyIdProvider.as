package alternativa.tanks.physics {
  import alternativa.tanks.utils.BitVector;

  public class TankBodyIdProvider {
    private static const MAX_IDS:int = 64;
    private static const instance:TankBodyIdProvider = new TankBodyIdProvider();

    private const ids:Vector.<int> = new Vector.<int>(MAX_IDS,true);
    private const claimedIds:BitVector = new BitVector(MAX_IDS);

    private var firstFreeIdIndex:int;

    public function TankBodyIdProvider() {
      super();
      this.reset();
    }

    public static function claimId() : int {
      return instance.claim();
    }

    public static function releaseId(param1:int) : void {
      instance.release(param1);
    }

    public static function resetIds() : void {
      instance.reset();
    }

    public function claim() : int {
      var local1:int = 0;
      if(this.firstFreeIdIndex < MAX_IDS) {
        local1 = this.ids[this.firstFreeIdIndex++];
        this.claimedIds.setBit(local1);
        return local1;
      }
      throw new Error();
    }

    public function release(param1:int) : void {
      if(this.claimedIds.getBit(param1) == 1) {
        this.claimedIds.clearBit(param1);
        var local2:* = --this.firstFreeIdIndex;
        this.ids[local2] = param1;
      }
    }

    public function reset() : void {
      this.firstFreeIdIndex = 0;
      var local1:int = 0;
      while(local1 < MAX_IDS) {
        this.ids[local1] = local1;
        local1++;
      }
      this.claimedIds.clear();
    }
  }
}
