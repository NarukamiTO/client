package alternativa.tanks.models.controlpoints.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.utils.TextureMaterialRegistry;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class AllBeamProperties {
    private static const conBeamWidth:ConsoleVarFloat = new ConsoleVarFloat("beam_width",100,0,1000);
    private static const conUnitLength:ConsoleVarFloat = new ConsoleVarFloat("beam_ulength",500,0,10000);
    private static const conAnimationSpeed:ConsoleVarFloat = new ConsoleVarFloat("beam_anim_speed",-0.6,-1000,1000);
    private static const conURange:ConsoleVarFloat = new ConsoleVarFloat("beam_urange",0.6,0.1,1);
    private static const conAlpha:ConsoleVarFloat = new ConsoleVarFloat("beam_alpha",1,0,1);

    private var blueBeamProperties:BeamProperties;
    private var redBeamProperties:BeamProperties;

    public function AllBeamProperties(param1:TextureMaterialRegistry, param2:DominationResources) {
      super();
      this.blueBeamProperties = createBeamProperties(param1,param2.blueRay,param2.blueRayTip,50,100,1,1,1);
      this.redBeamProperties = createBeamProperties(param1,param2.redRay,param2.redRayTip,50,100,1,1,1);
    }

    private static function createBeamProperties(param1:TextureMaterialRegistry, param2:TextureResource, param3:TextureResource, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : BeamProperties {
      var local9:TextureMaterial = param1.getMaterial(param2.data);
      local9.repeat = true;
      var local10:TextureMaterial = param1.getMaterial(param3.data);
      return new BeamProperties(local9,local10,param4,param5,param6,param7,param8);
    }

    private static function createProperties(param1:BeamProperties) : BeamProperties {
      return new BeamProperties(param1.beamMaterial,param1.beamTipMaterial,conBeamWidth.value,conUnitLength.value,conAnimationSpeed.value,conURange.value,conAlpha.value);
    }

    private function getBlueBeamProperties() : BeamProperties {
      return createProperties(this.blueBeamProperties);
    }

    private function getRedBeamProperties() : BeamProperties {
      return createProperties(this.redBeamProperties);
    }

    public function getBeamProperties(param1:BattleTeam) : BeamProperties {
      return param1 == BattleTeam.BLUE ? this.getBlueBeamProperties() : this.getRedBeamProperties();
    }
  }
}
