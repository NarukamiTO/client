package alternativa.tanks.models.battle.meteor.nuclear {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.utils.objectpool.ObjectPool;

  public class NuclearBangEffect {
    internal static const SIZE:Number = 550;
    internal static const COUNT1:int = 20;
    internal static const RADIUS1:Number = 1000;
    internal static const HEIGHT1:Number = 2000;
    internal static const COUNT2:int = 15;
    internal static const RADIUS2:Number = 850;
    internal static const HEIGHT2:Number = HEIGHT1 + SIZE * 0.6;
    internal static const COUNT3:int = 11;
    internal static const RADIUS3:Number = 650;
    internal static const HEIGHT3:Number = HEIGHT2 + SIZE * 0.4;
    internal static const COUNT4:int = 7;
    internal static const RADIUS4:Number = 290;
    internal static const HEIGHT4:Number = HEIGHT3 + SIZE * 0.3;
    internal static const COUNT5:int = 12;
    internal static const RADIUS5:Number = 800;
    internal static const HEIGHT5:Number = HEIGHT1 + SIZE * 0.1;
    internal static const COUNT6:int = 2;
    internal static const RADIUS6:Number = 50;
    internal static const HEIGHT6:Number = HEIGHT1 - SIZE * 0.5;
    internal static const COUNT7:int = 3;
    internal static const RADIUS7:Number = 120;
    internal static const HEIGHT7:Number = HEIGHT6 - SIZE * 0.5;
    internal static const COUNT8:int = 4;
    internal static const RADIUS8:Number = 200;
    internal static const HEIGHT8:Number = HEIGHT7 - SIZE * 0.5;
    internal static const COUNT9:int = 4;
    internal static const RADIUS9:Number = 160;
    internal static const HEIGHT9:Number = HEIGHT8 - SIZE * 0.2;
    internal static const COUNT10:int = 3;
    internal static const RADIUS10:Number = 50;
    internal static const HEIGHT10:Number = HEIGHT9 - SIZE * 0.6;
    internal static const COUNT11:int = 6;
    internal static const RADIUS11:Number = 150;
    internal static const HEIGHT11:Number = HEIGHT10 - SIZE * 0.5;
    internal static const COUNT12:int = 9;
    internal static const RADIUS12:Number = 450;
    internal static const HEIGHT12:Number = HEIGHT11 - SIZE * 0.4;
    internal static const COUNT13:int = 10;
    internal static const RADIUS13:Number = 550;
    internal static const HEIGHT13:Number = HEIGHT12 - SIZE * 0.1;
    internal static const KEY1:Number = 10 / 60;
    internal static const KEY2:Number = 120 / 60;
    internal static const END:Number = 160 / 60;

    internal var pool:ObjectPool;
    internal var lightMaterial:TextureMaterial;
    internal var waveMaterial:TextureMaterial;
    internal var smokeMaterial:TextureMaterial;
    internal var flameMaterial:TextureMaterial;

    public function NuclearBangEffect(param1:ObjectPool, param2:TextureMaterial, param3:TextureMaterial, param4:TextureMaterial, param5:TextureMaterial) {
      super();
      this.pool = param1;
      this.lightMaterial = param2;
      this.waveMaterial = param3;
      this.smokeMaterial = param4;
      this.flameMaterial = param5;
    }

    public function play(param1:Vector3, param2:BattleScene3D) : void {
      this.createRound(param1,param2,COUNT1,RADIUS1,HEIGHT1,0.6,0,true);
      this.createRound(param1,param2,COUNT2,RADIUS2,HEIGHT2,0.6,0,true);
      this.createRound(param1,param2,COUNT3,RADIUS3,HEIGHT3,0.6,0,true);
      this.createRound(param1,param2,COUNT4,RADIUS4,HEIGHT4,0.6,0,true);
      this.createRound(param1,param2,COUNT5,RADIUS5,HEIGHT5,0.7,0.4,false);
      this.createRound(param1,param2,COUNT6,RADIUS6,HEIGHT6,0.6,0,true);
      this.createRound(param1,param2,COUNT7,RADIUS7,HEIGHT7,0.6,-0.4,true);
      this.createRound(param1,param2,COUNT8,RADIUS8,HEIGHT8,0.6,0,true);
      this.createRound(param1,param2,COUNT9,RADIUS9,HEIGHT9,0.7,-0.2,false);
      this.createRound(param1,param2,COUNT10,RADIUS10,HEIGHT10,0.6,-0.3,true);
      this.createRound(param1,param2,COUNT11,RADIUS11,HEIGHT11,0.6,0,true);
      this.createRound(param1,param2,COUNT12,RADIUS12,HEIGHT12,0.6,0,true);
      this.createRound(param1,param2,COUNT13,RADIUS13,HEIGHT13,0.7,-0.2,false);
      var local3:NuclearLightEffect = NuclearLightEffect(this.pool.getObject(NuclearLightEffect));
      local3.init(param1,this.lightMaterial);
      param2.addGraphicEffect(local3);
      var local4:NuclearLightWaveEffect = NuclearLightWaveEffect(this.pool.getObject(NuclearLightWaveEffect));
      local4.init(param1,this.waveMaterial);
      param2.addGraphicEffect(local4);
    }

    private function createRound(param1:Vector3, param2:BattleScene3D, param3:int, param4:Number, param5:Number, param6:Number, param7:Number, param8:Boolean) : void {
      var local9:Number = NaN;
      var local11:Vector3 = null;
      var local12:Number = NaN;
      var local13:NuclearBangSprite = null;
      local9 = Math.PI * 2 / param3;
      var local10:int = 0;
      while(local10 < param3) {
        local11 = new Vector3();
        local11.x = Math.cos(local10 * local9) * param4;
        local11.y = Math.sin(local10 * local9) * param4;
        local11.z = param5 - 100;
        local12 = 1 + Math.random() * param6 + param7;
        local13 = NuclearBangSprite(this.pool.getObject(NuclearBangSprite));
        if(param8) {
          local13.initSmoke(param1,local11,local12,this.smokeMaterial);
        } else {
          local13.initFlame(param1,local11,local12,this.flameMaterial);
        }
        param2.addGraphicEffect(local13);
        local10++;
      }
    }
  }
}
