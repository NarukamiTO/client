package _codec.projects.tanks.client.commons.types {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class CodecItemGarageProperty implements ICodec {
    public function CodecItemGarageProperty() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemGarageProperty = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ItemGarageProperty.HULL_ARMOR;
          break;
        case 1:
          local2 = ItemGarageProperty.HULL_SPEED;
          break;
        case 2:
          local2 = ItemGarageProperty.HULL_TURN_SPEED;
          break;
        case 3:
          local2 = ItemGarageProperty.HULL_POWER;
          break;
        case 4:
          local2 = ItemGarageProperty.HULL_MASS;
          break;
        case 5:
          local2 = ItemGarageProperty.ALL_RESISTANCE;
          break;
        case 6:
          local2 = ItemGarageProperty.FIREBIRD_RESISTANCE;
          break;
        case 7:
          local2 = ItemGarageProperty.SMOKY_RESISTANCE;
          break;
        case 8:
          local2 = ItemGarageProperty.TWINS_RESISTANCE;
          break;
        case 9:
          local2 = ItemGarageProperty.RAILGUN_RESISTANCE;
          break;
        case 10:
          local2 = ItemGarageProperty.ISIS_RESISTANCE;
          break;
        case 11:
          local2 = ItemGarageProperty.MINE_RESISTANCE;
          break;
        case 12:
          local2 = ItemGarageProperty.THUNDER_RESISTANCE;
          break;
        case 13:
          local2 = ItemGarageProperty.FREEZE_RESISTANCE;
          break;
        case 14:
          local2 = ItemGarageProperty.RICOCHET_RESISTANCE;
          break;
        case 15:
          local2 = ItemGarageProperty.SHAFT_RESISTANCE;
          break;
        case 16:
          local2 = ItemGarageProperty.SHOTGUN_RESISTANCE;
          break;
        case 17:
          local2 = ItemGarageProperty.MACHINE_GUN_RESISTANCE;
          break;
        case 18:
          local2 = ItemGarageProperty.ROCKET_LAUNCHER_RESISTANCE;
          break;
        case 19:
          local2 = ItemGarageProperty.ARTILLERY_RESISTANCE;
          break;
        case 20:
          local2 = ItemGarageProperty.GAUSS_RESISTANCE;
          break;
        case 21:
          local2 = ItemGarageProperty.DAMAGE;
          break;
        case 22:
          local2 = ItemGarageProperty.DAMAGE_PER_SECOND;
          break;
        case 23:
          local2 = ItemGarageProperty.WEAPON_COOLDOWN_TIME;
          break;
        case 24:
          local2 = ItemGarageProperty.AIMING_MODE_COOLDOWN_TIME;
          break;
        case 25:
          local2 = ItemGarageProperty.CRITICAL_HIT_CHANCE;
          break;
        case 26:
          local2 = ItemGarageProperty.CRITICAL_HIT_DAMAGE;
          break;
        case 27:
          local2 = ItemGarageProperty.SHOT_RANGE;
          break;
        case 28:
          local2 = ItemGarageProperty.TURRET_TURN_SPEED;
          break;
        case 29:
          local2 = ItemGarageProperty.AIMING_ERROR;
          break;
        case 30:
          local2 = ItemGarageProperty.SHOT_AREA;
          break;
        case 31:
          local2 = ItemGarageProperty.CONE_ANGLE;
          break;
        case 32:
          local2 = ItemGarageProperty.CHARGING_TIME;
          break;
        case 33:
          local2 = ItemGarageProperty.FIRE_DAMAGE;
          break;
        case 34:
          local2 = ItemGarageProperty.WEAPON_WEAKENING_COEFF;
          break;
        case 35:
          local2 = ItemGarageProperty.ISIS_DAMAGE;
          break;
        case 36:
          local2 = ItemGarageProperty.ISIS_HEALING_PER_SECOND;
          break;
        case 37:
          local2 = ItemGarageProperty.AIMING_MODE_DAMAGE;
          break;
        case 38:
          local2 = ItemGarageProperty.AIMING_WEAPON_DISCHARGE_RATE;
          break;
        case 39:
          local2 = ItemGarageProperty.SHAFT_AIMED_SHOT_IMPACT;
          break;
        case 40:
          local2 = ItemGarageProperty.SHAFT_TARGETING_SPEED;
          break;
        case 41:
          local2 = ItemGarageProperty.SHAFT_ARCADE_DAMAGE;
          break;
        case 42:
          local2 = ItemGarageProperty.GAUSS_AIMING_MODE_DAMAGE;
          break;
        case 43:
          local2 = ItemGarageProperty.WEAPON_IMPACT_FORCE;
          break;
        case 44:
          local2 = ItemGarageProperty.WEAPON_KICKBACK;
          break;
        case 45:
          local2 = ItemGarageProperty.SHELL_SPEED;
          break;
        case 46:
          local2 = ItemGarageProperty.WEAPON_CHARGE_RATE;
          break;
        case 47:
          local2 = ItemGarageProperty.WEAPON_MIN_DAMAGE_PERCENT;
          break;
        case 48:
          local2 = ItemGarageProperty.THUNDER_MIN_SPLASH_DAMAGE_PERCENT;
          break;
        case 49:
          local2 = ItemGarageProperty.DEPENDENCY_FIRST_AID_SEC;
          break;
        case 50:
          local2 = ItemGarageProperty.DEPENDENCY_DOUBLE_ARMOR_SEC;
          break;
        case 51:
          local2 = ItemGarageProperty.DEPENDENCY_DOUBLE_DAMAGE_SEC;
          break;
        case 52:
          local2 = ItemGarageProperty.DEPENDENCY_NITRO_SEC;
          break;
        case 53:
          local2 = ItemGarageProperty.DEPENDENCY_MINE_SEC;
          break;
        case 54:
          local2 = ItemGarageProperty.DEPENDENCY_DROPPABLE_GOLD_SEC;
          break;
        case 55:
          local2 = ItemGarageProperty.COOLDOWN_FIRST_AID_SEC;
          break;
        case 56:
          local2 = ItemGarageProperty.COOLDOWN_DOUBLE_ARMOR_SEC;
          break;
        case 57:
          local2 = ItemGarageProperty.COOLDOWN_DOUBLE_DAMAGE_SEC;
          break;
        case 58:
          local2 = ItemGarageProperty.COOLDOWN_NITRO_SEC;
          break;
        case 59:
          local2 = ItemGarageProperty.COOLDOWN_MINE_SEC;
          break;
        case 60:
          local2 = ItemGarageProperty.COOLDOWN_DROPPABLE_GOLD_SEC;
          break;
        case 61:
          local2 = ItemGarageProperty.DURATION_FIRST_AID_SEC;
          break;
        case 62:
          local2 = ItemGarageProperty.DURATION_DOUBLE_ARMOR_SEC;
          break;
        case 63:
          local2 = ItemGarageProperty.DURATION_DOUBLE_DAMAGE_SEC;
          break;
        case 64:
          local2 = ItemGarageProperty.DURATION_NITRO_SEC;
          break;
        case 65:
          local2 = ItemGarageProperty.ATTACK_EFFECT;
          break;
        case 66:
          local2 = ItemGarageProperty.FIRST_AID_EFFECT_INSTANT;
          break;
        case 67:
          local2 = ItemGarageProperty.FIRST_AID_EFFECT;
          break;
        case 68:
          local2 = ItemGarageProperty.PROTECTION_EFFECT;
          break;
        case 69:
          local2 = ItemGarageProperty.SPEED_EFFECT;
          break;
        case 70:
          local2 = ItemGarageProperty.SHOTGUN_IMPACT_FORCE;
          break;
        case 71:
          local2 = ItemGarageProperty.DISCHARGE_SPEED;
          break;
        case 72:
          local2 = ItemGarageProperty.FREEZE_PER_TICK;
          break;
        case 73:
          local2 = ItemGarageProperty.VERTICAL_ANGLES;
          break;
        case 74:
          local2 = ItemGarageProperty.DRONE_RELOAD;
          break;
        case 75:
          local2 = ItemGarageProperty.DRONE_REPAIR_HEALTH;
          break;
        case 76:
          local2 = ItemGarageProperty.DRONE_INVENTORY;
          break;
        case 77:
          local2 = ItemGarageProperty.DRONE_INVENTORY_ADD;
          break;
        case 78:
          local2 = ItemGarageProperty.DRONE_BONUS_ADD;
          break;
        case 79:
          local2 = ItemGarageProperty.DRONE_FIRST_AID_BONUS_ADD;
          break;
        case 80:
          local2 = ItemGarageProperty.DRONE_OVERDRIVE_BOOST;
          break;
        case 81:
          local2 = ItemGarageProperty.DRONE_DEFEND;
          break;
        case 82:
          local2 = ItemGarageProperty.DRONE_ARMOR_BOOST;
          break;
        case 83:
          local2 = ItemGarageProperty.DRONE_MINE;
          break;
        case 84:
          local2 = ItemGarageProperty.DRONE_ADDITIONAL_MINES;
          break;
        case 85:
          local2 = ItemGarageProperty.DRONE_MINES_ACTIVATION_DELAY;
          break;
        case 86:
          local2 = ItemGarageProperty.DRONE_MINES_PLACEMENT_RADIUS;
          break;
        case 87:
          local2 = ItemGarageProperty.DRONE_INVENTORY_COOLDOWN_BOOST;
          break;
        case 88:
          local2 = ItemGarageProperty.DRONE_POWER_BOOST;
          break;
        case 89:
          local2 = ItemGarageProperty.DRONE_POWER_DURATION;
          break;
        case 90:
          local2 = ItemGarageProperty.DRONE_CRITICAL_HEALTH;
          break;
        case 91:
          local2 = ItemGarageProperty.DRONE_REPAIR_RADIUS;
          break;
        case 92:
          local2 = ItemGarageProperty.DRONE_INVENTORY_RADIUS;
          break;
        case 93:
          local2 = ItemGarageProperty.DRONE_COOLDOWN_RADIUS;
          break;
        case 94:
          local2 = ItemGarageProperty.DRONE_CONSTANT_ARMOR_PERCENT;
          break;
        case 95:
          local2 = ItemGarageProperty.DRONE_CONSTANT_POWER_PERCENT;
          break;
        case 96:
          local2 = ItemGarageProperty.ULTIMATE_HEAL_HP;
          break;
        case 97:
          local2 = ItemGarageProperty.ULTIMATE_CHARGE_PER_SEC;
          break;
        case 98:
          local2 = ItemGarageProperty.ULTIMATE_CHARGE_PER_SCORE_POINT;
          break;
        case 99:
          local2 = ItemGarageProperty.ULTIMATE_SCORE_COOLDOWN_SEC;
          break;
        case 100:
          local2 = ItemGarageProperty.ULTIMATE_ACTIVATION_DISCHARGE_PER_SEC;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
