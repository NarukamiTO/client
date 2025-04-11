package alternativa.tanks.service.itempropertyparams {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.ItemInfoPanelBitmaps;
  import alternativa.tanks.model.garage.resistance.ResistancesIcons;
  import alternativa.tanks.model.garage.temperature.TemperatureConfig;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.UpgradeAggregationMode;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.UpgradeAggregationModes;
  import flash.display.BitmapData;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ItemPropertyParamsServiceImpl implements ItemPropertyParamsService {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var logger:IClientLog;

    [Inject]
    public static var temperatureConfig:TemperatureConfig;

    private static const RADIAN_TO_ANGLE_MULTIPLIER:Number = 180 / Math.PI;
    private static const ISIS_HEALING_MULTIPLIER:int = 4;
    private static const ISIS_DAMAGE_MULTIPLIER:int = 4;
    private static const STREAM_WEAPONS_DAMAGE_MULTIPLIER:int = 4;

    private var itemPropertyParamsMap:Object;

    public function ItemPropertyParamsServiceImpl() {
      super();
    }

    public function getParams(param1:ItemGarageProperty) : ItemPropertyParams {
      var local3:Error = null;
      if(this.itemPropertyParamsMap == null) {
        this.initPropertyParamsMap();
      }
      var local2:ItemPropertyParams = this.itemPropertyParamsMap[param1];
      if(local2 == null) {
        local3 = new Error("Not found params for property " + param1);
        logger.logError("error",local3.message);
        throw local3;
      }
      return local2;
    }

    public function initPropertyParamsMap() : void {
      this.itemPropertyParamsMap = {};
      this.registerGarageProperty(ItemGarageProperty.HULL_ARMOR,1,ItemInfoPanelBitmaps.armor,TanksLocale.TEXT_GARAGE_PROTECTION_PROPERTY,ItemProperty.HULL_ARMOR);
      this.registerGarageProperty(ItemGarageProperty.HULL_SPEED,2,ItemInfoPanelBitmaps.speed,TanksLocale.TEXT_GARAGE_MAX_SPEED_PROPERTY,ItemProperty.HULL_SPEED);
      this.registerGarageProperty(ItemGarageProperty.HULL_TURN_SPEED,3,ItemInfoPanelBitmaps.turnspeed,TanksLocale.TEXT_GARAGE_TURN_PROPERTY,ItemProperty.HULL_TURN_SPEED);
      this.registerGarageProperty(ItemGarageProperty.HULL_MASS,4,ItemInfoPanelBitmaps.hullMass,TanksLocale.TEXT_GARAGE_WEIGHT_PROPERTY,ItemProperty.HULL_MASS);
      this.registerGarageProperty(ItemGarageProperty.HULL_POWER,5,ItemInfoPanelBitmaps.hullPower,TanksLocale.TEXT_GARAGE_POWER_PROPERTY,ItemProperty.HULL_ACCELERATION,100);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.DAMAGE,3,ItemInfoPanelBitmaps.damage,TanksLocale.TEXT_GARAGE_DAMAGE_PROPERTY,ItemProperty.DAMAGE_FROM,ItemProperty.DAMAGE_TO,1,UpgradeAggregationModes.RANGE);
      this.registerGarageProperty(ItemGarageProperty.ISIS_HEALING_PER_SECOND,1,ItemInfoPanelBitmaps.continuousHealBitmapData,TanksLocale.TEXT_GARAGE_HEAL_PROPERTY,ItemProperty.ISIS_HEALING_PER_PERIOD,ISIS_HEALING_MULTIPLIER);
      this.registerGarageProperty(ItemGarageProperty.ISIS_DAMAGE,2,ItemInfoPanelBitmaps.vampireRate,TanksLocale.TEXT_GARAGE_DAMAGE_PROPERTY,ItemProperty.DAMAGE_PER_PERIOD,ISIS_DAMAGE_MULTIPLIER);
      this.registerGarageProperty(ItemGarageProperty.DAMAGE_PER_SECOND,3,ItemInfoPanelBitmaps.damage,TanksLocale.TEXT_GARAGE_DAMAGE_PROPERTY,ItemProperty.DAMAGE_PER_PERIOD,STREAM_WEAPONS_DAMAGE_MULTIPLIER);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.WEAPON_COOLDOWN_TIME,5,ItemInfoPanelBitmaps.rateOfFire,TanksLocale.TEXT_GARAGE_RELOAD_PROPERTY,ItemProperty.WEAPON_RELOAD_TIME,ItemProperty.WEAPON_CHARGING_TIME,0.001);
      this.registerGarageProperty(ItemGarageProperty.WEAPON_CHARGE_RATE,5,ItemInfoPanelBitmaps.rateOfFire,TanksLocale.TEXT_GARAGE_RELOAD_PROPERTY,ItemProperty.WEAPON_RELOAD_TIME,0.001);
      this.registerGarageProperty(ItemGarageProperty.AIMING_MODE_DAMAGE,1,ItemInfoPanelBitmaps.shaftDamage,TanksLocale.TEXT_GARAGE_SNIPING_DAMAGE_PROPERTY,ItemProperty.SHAFT_AIMING_MODE_MAX_DAMAGE);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.GAUSS_AIMING_MODE_DAMAGE,1,ItemInfoPanelBitmaps.shaftDamage,TanksLocale.TEXT_GARAGE_GAUSS_AIMING_DAMAGE_PROPERTY,ItemProperty.SECONDARY_DAMAGE_FROM,ItemProperty.SECONDARY_DAMAGE_TO,1,UpgradeAggregationModes.RANGE);
      this.registerGarageProperty(ItemGarageProperty.SHAFT_AIMED_SHOT_IMPACT,2,ItemInfoPanelBitmaps.aimingImpactForce,TanksLocale.TEXT_GARAGE_SNIPING_IMPACT_PROPERTY,ItemProperty.SHAFT_AIMED_SHOT_IMPACT,100);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.SHAFT_ARCADE_DAMAGE,3,ItemInfoPanelBitmaps.damage,TanksLocale.TEXT_GARAGE_ARCADE_DAMAGE_PROPERTY,ItemProperty.DAMAGE_FROM,ItemProperty.DAMAGE_TO,1,UpgradeAggregationModes.RANGE);
      this.registerGarageProperty(ItemGarageProperty.TURRET_TURN_SPEED,7,ItemInfoPanelBitmaps.turretRotationRate,TanksLocale.TEXT_GARAGE_ROTATION_PROPERTY,ItemProperty.TURRET_TURN_SPEED,RADIAN_TO_ANGLE_MULTIPLIER);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.SHOT_RANGE,9,ItemInfoPanelBitmaps.range,TanksLocale.TEXT_GARAGE_RANGE_PROPERTY,ItemProperty.WEAPON_MIN_DAMAGE_RADIUS,ItemProperty.SHOT_RANGE);
      this.registerGarageProperty(ItemGarageProperty.WEAPON_MIN_DAMAGE_PERCENT,30,ItemInfoPanelBitmaps.minDamagePercent,TanksLocale.TEXT_GARAGE_DISTANT_DAMAGE_PROPERTY,ItemProperty.WEAPON_MIN_DAMAGE_PERCENT);
      this.registerResistanceProperty(ItemGarageProperty.SMOKY_RESISTANCE,13,ResistancesIcons.mechResistance,TanksLocale.TEXT_GARAGE_SMOKY_PROTECTION_PROPERTY,ItemProperty.SMOKY_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.FIREBIRD_RESISTANCE,14,ResistancesIcons.fireResistance,TanksLocale.TEXT_GARAGE_FIREBIRD_PROTECTION_PROPERTY,ItemProperty.FIREBIRD_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.TWINS_RESISTANCE,15,ResistancesIcons.plasmaResistance,TanksLocale.TEXT_GARAGE_TWINS_PROTECTION_PROPERTY,ItemProperty.TWINS_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.RAILGUN_RESISTANCE,16,ResistancesIcons.railResistance,TanksLocale.TEXT_GARAGE_RAILGUN_PROTECTION_PROPERTY,ItemProperty.RAILGUN_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.ISIS_RESISTANCE,17,ResistancesIcons.vampireResistance,TanksLocale.TEXT_GARAGE_ISIDA_PROTECTION_PROPERTY,ItemProperty.ISIS_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.THUNDER_RESISTANCE,18,ResistancesIcons.thunderResistance,TanksLocale.TEXT_GARAGE_THUNDER_PROTECTION_PROPERTY,ItemProperty.THUNDER_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.FREEZE_RESISTANCE,19,ResistancesIcons.freezeResistance,TanksLocale.TEXT_GARAGE_FREEZE_PROTECTION_PROPERTY,ItemProperty.FREEZE_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.RICOCHET_RESISTANCE,20,ResistancesIcons.ricochetResistance,TanksLocale.TEXT_GARAGE_RICOCHET_PROTECTION_PROPERTY,ItemProperty.RICOCHET_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.SHAFT_RESISTANCE,21,ResistancesIcons.shaftResistance,TanksLocale.TEXT_GARAGE_SHAFT_PROTECTION_PROPERTY,ItemProperty.SHAFT_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.MINE_RESISTANCE,22,ResistancesIcons.mineResistance,TanksLocale.TEXT_GARAGE_MINE_PROTECTION_PROPERTY,ItemProperty.MINE_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.SHOTGUN_RESISTANCE,23,ResistancesIcons.shotgunResistance,TanksLocale.TEXT_GARAGE_SHOTGUN_PROTECTION_PROPERTY,ItemProperty.SHOTGUN_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.MACHINE_GUN_RESISTANCE,24,ResistancesIcons.machinegunResistance,TanksLocale.TEXT_GARAGE_MACHINE_GUN_PROTECTION_PROPERTY,ItemProperty.MACHINE_GUN_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.ROCKET_LAUNCHER_RESISTANCE,25,ResistancesIcons.rocketLauncherResistance,TanksLocale.TEXT_GARAGE_ROCKET_LAUNCHER_PROTECTION_PROPERTY,ItemProperty.ROCKET_LAUNCHER_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.ALL_RESISTANCE,26,ResistancesIcons.allResistance,TanksLocale.TEXT_GARAGE_ALL_PROTECTION_PROPERTY,ItemProperty.ALL_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.ARTILLERY_RESISTANCE,27,ResistancesIcons.artilleryResistance,TanksLocale.TEXT_GARAGE_ARTILLERY_PROTECTION_PROPERTY,ItemProperty.ARTILLERY_RESISTANCE);
      this.registerResistanceProperty(ItemGarageProperty.GAUSS_RESISTANCE,28,ResistancesIcons.gaussResistance,TanksLocale.TEXT_GARAGE_GAUSS_PROTECTION_PROPERTY,ItemProperty.GAUSS_RESISTANCE);
      this.registerGarageProperty(ItemGarageProperty.WEAPON_IMPACT_FORCE,4,ItemInfoPanelBitmaps.impactForce,TanksLocale.TEXT_GARAGE_IMPACT_PROPERTY,ItemProperty.IMPACT_FORCE,100);
      this.registerGarageProperty(ItemGarageProperty.SHOTGUN_IMPACT_FORCE,4,ItemInfoPanelBitmaps.impactForce,TanksLocale.TEXT_GARAGE_IMPACT_PROPERTY,ItemProperty.IMPACT_FORCE,900);
      this.registerGarageProperty(ItemGarageProperty.WEAPON_WEAKENING_COEFF,28,ItemInfoPanelBitmaps.piercingCoeff,TanksLocale.TEXT_GARAGE_PENETRATING_PROPERTY,ItemProperty.WEAPON_WEAKENING_COEFF,100);
      this.registerGarageProperty(ItemGarageProperty.CRITICAL_HIT_CHANCE,23,ItemInfoPanelBitmaps.percent,TanksLocale.TEXT_GARAGE_CRITICAL_CHANCE_PROPERTY,ItemProperty.MAX_CRITICAL_HIT_CHANCE,100,UpgradeAggregationModes.CRIT);
      this.registerGarageProperty(ItemGarageProperty.CRITICAL_HIT_DAMAGE,24,ItemInfoPanelBitmaps.smokyCrit,TanksLocale.TEXT_GARAGE_CRITICAL_DAMAGE_PROPERTY,ItemProperty.CRITICAL_HIT_DAMAGE);
      this.registerGarageProperty(ItemGarageProperty.FIRE_DAMAGE,25,ItemInfoPanelBitmaps.firebird,TanksLocale.TEXT_GARAGE_BURN_PROPERTY,ItemProperty.FLAME_TEMPERATURE_LIMIT,1 / temperatureConfig.temperatureAutoDecrement);
      this.registerGaragePropertyWithTwoSubProperty(ItemGarageProperty.SHELL_SPEED,26,ItemInfoPanelBitmaps.shellSpeed,TanksLocale.TEXT_GARAGE_BULLET_SPEED_PROPERTY,ItemProperty.SHELL_SPEED,ItemProperty.MAX_SHELL_SPEED);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_DOUBLE_ARMOR_SEC,33,ItemInfoPanelBitmaps.cooldownDoubleArmorIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_DOUBLE_DAMAGE_SEC,33,ItemInfoPanelBitmaps.cooldownDoublePowerIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_FIRST_AID_SEC,33,ItemInfoPanelBitmaps.cooldownFirstAidIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_MINE_SEC,33,ItemInfoPanelBitmaps.cooldownMineIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_NITRO_SEC,33,ItemInfoPanelBitmaps.cooldownNitroIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DEPENDENCY_DROPPABLE_GOLD_SEC,33,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DURATION_DOUBLE_ARMOR_SEC,31,ItemInfoPanelBitmaps.durationEffectInventoryIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DURATION_DOUBLE_DAMAGE_SEC,31,ItemInfoPanelBitmaps.durationEffectInventoryIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DURATION_FIRST_AID_SEC,31,ItemInfoPanelBitmaps.durationEffectInventoryIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DURATION_NITRO_SEC,31,ItemInfoPanelBitmaps.durationEffectInventoryIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_DOUBLE_ARMOR_SEC,32,ItemInfoPanelBitmaps.cooldownDoubleArmorIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_DOUBLE_DAMAGE_SEC,32,ItemInfoPanelBitmaps.cooldownDoublePowerIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_FIRST_AID_SEC,32,ItemInfoPanelBitmaps.cooldownFirstAidIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_MINE_SEC,32,ItemInfoPanelBitmaps.cooldownMineIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_NITRO_SEC,32,ItemInfoPanelBitmaps.cooldownNitroIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.COOLDOWN_DROPPABLE_GOLD_SEC,32,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.ATTACK_EFFECT,30,ItemInfoPanelBitmaps.damage,null,null);
      this.registerGarageProperty(ItemGarageProperty.PROTECTION_EFFECT,30,ItemInfoPanelBitmaps.armor,null,null);
      this.registerGarageProperty(ItemGarageProperty.FIRST_AID_EFFECT_INSTANT,29,ItemInfoPanelBitmaps.instantHealBitmapData,null,null);
      this.registerGarageProperty(ItemGarageProperty.FIRST_AID_EFFECT,30,ItemInfoPanelBitmaps.continuousHealBitmapData,null,null);
      this.registerGarageProperty(ItemGarageProperty.SPEED_EFFECT,30,ItemInfoPanelBitmaps.speed,null,null);
      this.registerGarageProperty(ItemGarageProperty.DISCHARGE_SPEED,100,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.FREEZE_PER_TICK,100,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.CONE_ANGLE,100,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.VERTICAL_ANGLES,100,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DRONE_MINES_PLACEMENT_RADIUS,100,ItemInfoPanelBitmaps.cooldownGoldIcon,null,null);
      this.registerGarageProperty(ItemGarageProperty.DRONE_RELOAD,201,ItemInfoPanelBitmaps.droneReload,TanksLocale.TEXT_DRONE_RELOAD,ItemProperty.DRONE_RELOAD,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_REPAIR_HEALTH,202,ItemInfoPanelBitmaps.instantHealBitmapData,TanksLocale.TEXT_DRONE_REPAIR_HEALTH,ItemProperty.DRONE_REPAIR_HEALTH);
      this.registerGarageProperty(ItemGarageProperty.DRONE_REPAIR_RADIUS,203,ItemInfoPanelBitmaps.healRadius,TanksLocale.TEXT_DRONE_REPAIR_RADIUS,ItemProperty.DRONE_REPAIR_RADIUS);
      this.registerGarageProperty(ItemGarageProperty.DRONE_INVENTORY,203,ItemInfoPanelBitmaps.durationEffectInventoryIcon,TanksLocale.TEXT_DRONE_INVENTORY,ItemProperty.DRONE_INVENTORY,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_INVENTORY_ADD,204,ItemInfoPanelBitmaps.durationEffectInventoryIcon,TanksLocale.TEXT_DRONE_INVENTORY_ADD,ItemProperty.DRONE_INVENTORY_ADD,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_BONUS_ADD,205,ItemInfoPanelBitmaps.durationEffectInventoryIcon,TanksLocale.TEXT_DRONE_BONUS_ADD,ItemProperty.DRONE_BONUS_ADD,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_OVERDRIVE_BOOST,207,ItemInfoPanelBitmaps.droneOverdriveBoost,TanksLocale.TEXT_DRONE_OVERDRIVE_BOOST,ItemProperty.DRONE_OVERDRIVE_BOOST);
      this.registerGarageProperty(ItemGarageProperty.DRONE_DEFEND,208,ItemInfoPanelBitmaps.durationEffectInventoryIcon,TanksLocale.TEXT_DRONE_DEFEND,ItemProperty.DRONE_DEFEND,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_MINE,209,ItemInfoPanelBitmaps.surviveMinesIcon,TanksLocale.TEXT_DRONE_MINE,ItemProperty.DRONE_MINE);
      this.registerGarageProperty(ItemGarageProperty.DRONE_INVENTORY_COOLDOWN_BOOST,210,ItemInfoPanelBitmaps.cooldownBoostIcon,TanksLocale.TEXT_DRONE_INVENTORY_COOLDOWN_BOOST,ItemProperty.DRONE_INVENTORY_COOLDOWN_BOOST);
      this.registerGarageProperty(ItemGarageProperty.DRONE_POWER_BOOST,211,ItemInfoPanelBitmaps.powerBoostIcon,TanksLocale.TEXT_DRONE_POWER_BOOST,ItemProperty.DRONE_POWER_BOOST);
      this.registerGarageProperty(ItemGarageProperty.DRONE_POWER_DURATION,212,ItemInfoPanelBitmaps.durationEffectInventoryIcon,TanksLocale.TEXT_DRONE_POWER_DURATION,ItemProperty.DRONE_POWER_DURATION,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_CRITICAL_HEALTH,214,ItemInfoPanelBitmaps.instantHealBitmapData,TanksLocale.TEXT_DRONE_CRITICAL_HEALTH,ItemProperty.DRONE_CRITICAL_HEALTH);
      this.registerGarageProperty(ItemGarageProperty.DRONE_INVENTORY_RADIUS,215,ItemInfoPanelBitmaps.droneBonusRadius,TanksLocale.TEXT_DRONE_BONUS_RADIUS,ItemProperty.DRONE_INVENTORY_RADIUS);
      this.registerGarageProperty(ItemGarageProperty.DRONE_FIRST_AID_BONUS_ADD,216,ItemInfoPanelBitmaps.instantHealBitmapData,null,null);
      this.registerGarageProperty(ItemGarageProperty.ULTIMATE_HEAL_HP,215,ItemInfoPanelBitmaps.armor,"ULTIMATE_HEAL_HP",ItemProperty.ULTIMATE_HEAL_HP);
      this.registerGarageProperty(ItemGarageProperty.DRONE_ARMOR_BOOST,217,ItemInfoPanelBitmaps.armorBoostIcon,TanksLocale.TEXT_DRONE_ARMOR_BOOST,ItemProperty.DRONE_ARMOR_BOOST);
      this.registerGarageProperty(ItemGarageProperty.DRONE_ADDITIONAL_MINES,218,ItemInfoPanelBitmaps.additionalMinesIcon,TanksLocale.TEXT_DRONE_ADDITIONAL_MINES,ItemProperty.DRONE_ADDITIONAL_MINES);
      this.registerGarageProperty(ItemGarageProperty.DRONE_COOLDOWN_RADIUS,219,ItemInfoPanelBitmaps.cooldownRadiusIcon,TanksLocale.TEXT_DRONE_COOLDOWN_RADIUS,ItemProperty.DRONE_COOLDOWN_RADIUS);
      this.registerGarageProperty(ItemGarageProperty.DRONE_MINES_ACTIVATION_DELAY,220,ItemInfoPanelBitmaps.mineActivationDelayIcon,TanksLocale.TEXT_DRONE_MINES_ACTIVATION_DELAY,ItemProperty.DRONE_MINES_ACTIVATION_DELAY,0.001);
      this.registerGarageProperty(ItemGarageProperty.DRONE_CONSTANT_ARMOR_PERCENT,221,ItemInfoPanelBitmaps.armor,TanksLocale.DRONE_CONSTANT_ARMOR_PERCENT,ItemProperty.DRONE_CONSTANT_ARMOR_PERCENT);
      this.registerGarageProperty(ItemGarageProperty.DRONE_CONSTANT_POWER_PERCENT,222,ItemInfoPanelBitmaps.damage,TanksLocale.DRONE_CONSTANT_POWER_PERCENT,ItemProperty.DRONE_CONSTANT_POWER_PERCENT);
    }

    private function registerGarageProperty(param1:ItemGarageProperty, param2:int, param3:BitmapData, param4:String, param5:ItemProperty, param6:Number = 1, param7:UpgradeAggregationMode = null) : void {
      var local8:Vector.<ItemProperty> = new Vector.<ItemProperty>();
      local8.push(param5);
      this._registerProperty(param1,param2,param3,localeService.getText(param4),local8,param7,param6);
    }

    private function registerResistanceProperty(param1:ItemGarageProperty, param2:int, param3:BitmapData, param4:String, param5:ItemProperty, param6:Number = 1, param7:UpgradeAggregationMode = null) : void {
      var local8:Vector.<ItemProperty> = new Vector.<ItemProperty>();
      local8.push(param5);
      this._registerProperty(param1,param2,param3,localeService.getText(param4),local8,param7,param6,ResistancesIcons.resistanceIcon);
    }

    private function registerGaragePropertyWithTwoSubProperty(param1:ItemGarageProperty, param2:int, param3:BitmapData, param4:String, param5:ItemProperty, param6:ItemProperty, param7:Number = 1, param8:UpgradeAggregationMode = null) : void {
      var local9:Vector.<ItemProperty> = new Vector.<ItemProperty>();
      local9.push(param5);
      local9.push(param6);
      this._registerProperty(param1,param2,param3,localeService.getText(param4),local9,param8,param7);
    }

    private function _registerProperty(param1:ItemGarageProperty, param2:int, param3:BitmapData, param4:String, param5:Vector.<ItemProperty>, param6:UpgradeAggregationMode, param7:Number = 1, param8:BitmapData = null) : void {
      if(param6 == null) {
        param6 = UpgradeAggregationModes.SUM;
      }
      this.itemPropertyParamsMap[param1] = new ItemPropertyParams(param2,param3,param4,param5,param6,param7,param8);
    }
  }
}
