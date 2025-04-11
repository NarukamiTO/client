package alternativa.tanks.models.battle.meteor {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.utils.TextureMaterialRegistry;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorStormCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class MeteorSFXData {
    private var _tailLight:LightAnimation;
    private var _impactSoundTimerLabel:int;
    private var _meteorResource:Tanks3DSResource;
    private var _meteorDistantSound:Sound3D;
    private var _meteorArrivingSound:Sound3D;
    private var _nuclearBangSound:Sound3D;
    private var _tailSmoke:TextureMaterial;
    private var _tailFlame:TextureMaterial;
    private var _nuclearBangFlame:TextureMaterial;
    private var _nuclearBangLight:TextureMaterial;
    private var _nuclearBangSmoke:TextureMaterial;
    private var _nuclearBangWave:TextureMaterial;
    private var _craterDecal:TextureMaterial;

    public function MeteorSFXData(param1:MeteorStormCC, param2:TextureMaterialRegistry) {
      super();
      this._meteorResource = param1.meteorModel;
      this._impactSoundTimerLabel = param1.impactSoundTimelabel;
      this._tailLight = new LightAnimation(param1.tailLight);
      this._tailSmoke = param2.getMaterial(param1.tailSmoke.data);
      this._tailFlame = param2.getMaterial(param1.tailFlame.data);
      this._nuclearBangFlame = param2.getMaterial(param1.nuclearBangFlame.data);
      this._nuclearBangLight = param2.getMaterial(param1.nuclearBangLight.data);
      this._nuclearBangSmoke = param2.getMaterial(param1.nuclearBangSmoke.data);
      this._nuclearBangWave = param2.getMaterial(param1.nuclearBangWave.data);
      this._craterDecal = param2.getMaterial(param1.craterDecal.data);
      this._meteorDistantSound = Sound3D.create(param1.meteorDistantSound.sound);
      this._meteorArrivingSound = Sound3D.create(param1.meteorArrivingSound.sound);
      this._nuclearBangSound = Sound3D.create(param1.nuclearBangSound.sound);
    }

    public function get meteorResource() : Tanks3DSResource {
      return this._meteorResource;
    }

    public function get tailSmoke() : TextureMaterial {
      return this._tailSmoke;
    }

    public function get tailFlame() : TextureMaterial {
      return this._tailFlame;
    }

    public function get tailLight() : LightAnimation {
      return this._tailLight;
    }

    public function get nuclearBangFlame() : TextureMaterial {
      return this._nuclearBangFlame;
    }

    public function get nuclearBangLight() : TextureMaterial {
      return this._nuclearBangLight;
    }

    public function get nuclearBangSmoke() : TextureMaterial {
      return this._nuclearBangSmoke;
    }

    public function get nuclearBangWave() : TextureMaterial {
      return this._nuclearBangWave;
    }

    public function get meteorDistantSound() : Sound3D {
      return this._meteorDistantSound;
    }

    public function get meteorArrivingSound() : Sound3D {
      return this._meteorArrivingSound;
    }

    public function get nuclearBangSound() : Sound3D {
      return this._nuclearBangSound;
    }

    public function get craterDecal() : TextureMaterial {
      return this._craterDecal;
    }

    public function get impactSoundTimerLabel() : int {
      return this._impactSoundTimerLabel;
    }
  }
}
