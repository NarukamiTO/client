package _codec.projects.tanks.client.garage.models.item.properties {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class CodecItemProperty implements ICodec {
    public function CodecItemProperty() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemProperty = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = ItemProperty.HULL_ARMOR;
          break;
        case 1:
          local2 = ItemProperty.HULL_SPEED;
          break;
        case 2:
          local2 = ItemProperty.HULL_SIDE_ACCELERATION;
          break;
        case 3:
          local2 = ItemProperty.HULL_TURN_SPEED;
          break;
        case 4:
          local2 = ItemProperty.HULL_TURN_ACCELERATION;
          break;
        case 5:
          local2 = ItemProperty.HULL_REVERSE_TURN_ACCELERATION;
          break;
        case 6:
          local2 = ItemProperty.HULL_TURN_STABILIZATION_ACCELERATION;
          break;
        case 7:
          local2 = ItemProperty.HULL_ACCELERATION;
          break;
        case 8:
          local2 = ItemProperty.HULL_REVERSE_ACCELERATION;
          break;
        case 9:
          local2 = ItemProperty.HULL_MASS;
          break;
        case 10:
          local2 = ItemProperty.TURRET_TURN_SPEED;
          break;
        case 11:
          local2 = ItemProperty.TURRET_ROTATION_ACCELERATION;
          break;
        case 12:
          local2 = ItemProperty.INITIAL_TURRET_ANGLE;
          break;
        case 13:
          local2 = ItemProperty.IMPACT_FORCE;
          break;
        case 14:
          local2 = ItemProperty.DAMAGE_FROM;
          break;
        case 15:
          local2 = ItemProperty.DAMAGE_TO;
          break;
        case 16:
          local2 = ItemProperty.DAMAGE_PER_SECOND;
          break;
        case 17:
          local2 = ItemProperty.WEAPON_RELOAD_TIME;
          break;
        case 18:
          local2 = ItemProperty.WEAPON_CHARGING_TIME;
          break;
        case 19:
          local2 = ItemProperty.WEAPON_WEAKENING_COEFF;
          break;
        case 20:
          local2 = ItemProperty.FIREBIRD_RESISTANCE;
          break;
        case 21:
          local2 = ItemProperty.SMOKY_RESISTANCE;
          break;
        case 22:
          local2 = ItemProperty.TWINS_RESISTANCE;
          break;
        case 23:
          local2 = ItemProperty.RAILGUN_RESISTANCE;
          break;
        case 24:
          local2 = ItemProperty.ISIS_RESISTANCE;
          break;
        case 25:
          local2 = ItemProperty.MINE_RESISTANCE;
          break;
        case 26:
          local2 = ItemProperty.THUNDER_RESISTANCE;
          break;
        case 27:
          local2 = ItemProperty.FREEZE_RESISTANCE;
          break;
        case 28:
          local2 = ItemProperty.RICOCHET_RESISTANCE;
          break;
        case 29:
          local2 = ItemProperty.SHAFT_RESISTANCE;
          break;
        case 30:
          local2 = ItemProperty.MACHINE_GUN_RESISTANCE;
          break;
        case 31:
          local2 = ItemProperty.SHOTGUN_RESISTANCE;
          break;
        case 32:
          local2 = ItemProperty.ROCKET_LAUNCHER_RESISTANCE;
          break;
        case 33:
          local2 = ItemProperty.ARTILLERY_RESISTANCE;
          break;
        case 34:
          local2 = ItemProperty.TERMINATOR_RESISTANCE;
          break;
        case 35:
          local2 = ItemProperty.GAUSS_RESISTANCE;
          break;
        case 36:
          local2 = ItemProperty.ALL_RESISTANCE;
          break;
        case 37:
          local2 = ItemProperty.SHAFT_AIMING_MODE_MIN_DAMAGE;
          break;
        case 38:
          local2 = ItemProperty.SHAFT_AIMING_MODE_MAX_DAMAGE;
          break;
        case 39:
          local2 = ItemProperty.SHAFT_VERTICAL_TARGETING_SPEED;
          break;
        case 40:
          local2 = ItemProperty.SHAFT_HORIZONTAL_TARGETING_SPEED;
          break;
        case 41:
          local2 = ItemProperty.SHAFT_AIMING_MODE_CHARGE_RATE;
          break;
        case 42:
          local2 = ItemProperty.SHAFT_AIMED_SHOT_IMPACT;
          break;
        case 43:
          local2 = ItemProperty.SHAFT_ROTATION_DECELERATION_COEFF;
          break;
        case 44:
          local2 = ItemProperty.SHAFT_FAST_SHOT_ENERGY;
          break;
        case 45:
          local2 = ItemProperty.SHAFT_MIN_AIMED_SHOT_ENERGY;
          break;
        case 46:
          local2 = ItemProperty.WEAPON_CHARGE_RATE;
          break;
        case 47:
          local2 = ItemProperty.WEAPON_KICKBACK;
          break;
        case 48:
          local2 = ItemProperty.WEAPON_MIN_DAMAGE_PERCENT;
          break;
        case 49:
          local2 = ItemProperty.WEAPON_MIN_DAMAGE_RADIUS;
          break;
        case 50:
          local2 = ItemProperty.WEAPON_MAX_DAMAGE_RADIUS;
          break;
        case 51:
          local2 = ItemProperty.SHOT_RANGE;
          break;
        case 52:
          local2 = ItemProperty.MAX_CRITICAL_HIT_CHANCE;
          break;
        case 53:
          local2 = ItemProperty.START_CRITICAL_HIT_CHANCE;
          break;
        case 54:
          local2 = ItemProperty.AFTER_CRIT_CRITICAL_HIT_CHANCE;
          break;
        case 55:
          local2 = ItemProperty.CRITICAL_CHANCE_DELTA;
          break;
        case 56:
          local2 = ItemProperty.CRITICAL_HIT_CHANCE;
          break;
        case 57:
          local2 = ItemProperty.CRITICAL_HIT_DAMAGE;
          break;
        case 58:
          local2 = ItemProperty.SPLASH_DAMAGE_RADIUS;
          break;
        case 59:
          local2 = ItemProperty.RADIUS_OF_MAX_SPLASH_DAMAGE;
          break;
        case 60:
          local2 = ItemProperty.MIN_SPLASH_DAMAGE_PERCENT;
          break;
        case 61:
          local2 = ItemProperty.SPLASH_DAMAGE_IMPACT;
          break;
        case 62:
          local2 = ItemProperty.RADIUS_OF_FIRST_DIMINUTION_SPLASH_DAMAGE;
          break;
        case 63:
          local2 = ItemProperty.FIRST_DIMINUTION_SPLASH_DAMAGE_PERCENT;
          break;
        case 64:
          local2 = ItemProperty.WEAPON_DISCHARGE_RATE;
          break;
        case 65:
          local2 = ItemProperty.DAMAGE_PER_PERIOD;
          break;
        case 66:
          local2 = ItemProperty.ISIS_HEALING_PER_PERIOD;
          break;
        case 67:
          local2 = ItemProperty.ISIS_INCREASE_TARGET_TEMPERATURE_PER_TICK;
          break;
        case 68:
          local2 = ItemProperty.ISIS_DECREASE_TARGET_TEMPERATURE_PER_TICK;
          break;
        case 69:
          local2 = ItemProperty.ISIS_DISCHARGE_SPEED_HEALING;
          break;
        case 70:
          local2 = ItemProperty.ISIS_DISCHARGE_SPEED_IDLE;
          break;
        case 71:
          local2 = ItemProperty.FLAME_TEMPERATURE_LIMIT;
          break;
        case 72:
          local2 = ItemProperty.HEAT_PER_PERIOD;
          break;
        case 73:
          local2 = ItemProperty.ENERGY_PER_SHOT;
          break;
        case 74:
          local2 = ItemProperty.MACHINE_GUN_SELF_TEMPERATURE_INCREASE_PER_SECOND;
          break;
        case 75:
          local2 = ItemProperty.MACHINE_GUN_SPIN_UP_TIME_SECOND;
          break;
        case 76:
          local2 = ItemProperty.MACHINE_GUN_SPIN_DOWN_TIME_SECOND;
          break;
        case 77:
          local2 = ItemProperty.MACHINE_GUN_WEAPON_TURN_DECELERATION_COEFF;
          break;
        case 78:
          local2 = ItemProperty.MACHINE_GUN_TEMPERATURE_HITTING_TIME_SECOND;
          break;
        case 79:
          local2 = ItemProperty.MACHINE_GUN_OVERHEAT_DAMAGE_COEFF;
          break;
        case 80:
          local2 = ItemProperty.MACHINE_GUN_POWER_WHEN_TANK_TEMPERATURE_START_INCREASE;
          break;
        case 81:
          local2 = ItemProperty.ELLIPTIC_CONE_VERTICAL_ANGLE;
          break;
        case 82:
          local2 = ItemProperty.ELLIPTIC_CONE_HORIZONTAL_ANGLE;
          break;
        case 83:
          local2 = ItemProperty.SHOTGUN_MAGAZINE_SIZE;
          break;
        case 84:
          local2 = ItemProperty.SHOTGUN_PELLET_COUNT;
          break;
        case 85:
          local2 = ItemProperty.MAGAZINE_RELOAD_TIME;
          break;
        case 86:
          local2 = ItemProperty.DAMAGE_PER_HIT;
          break;
        case 87:
          local2 = ItemProperty.DISCHARGE_SPEED;
          break;
        case 88:
          local2 = ItemProperty.CONE_ANGLE;
          break;
        case 89:
          local2 = ItemProperty.FREEZE_PER_TICK;
          break;
        case 90:
          local2 = ItemProperty.WEAPON_ANGLE_UP;
          break;
        case 91:
          local2 = ItemProperty.WEAPON_ANGLE_DOWN;
          break;
        case 92:
          local2 = ItemProperty.ROCKET_ANGULAR_VELOCITY;
          break;
        case 93:
          local2 = ItemProperty.SALVO_AIMING_TIME;
          break;
        case 94:
          local2 = ItemProperty.SALVO_AIMING_GRACE_PERIOD;
          break;
        case 95:
          local2 = ItemProperty.TIME_BETWEEN_SHOTS_OF_SALVO;
          break;
        case 96:
          local2 = ItemProperty.SALVO_RELOAD_TIME;
          break;
        case 97:
          local2 = ItemProperty.SALVO_SIZE;
          break;
        case 98:
          local2 = ItemProperty.SHELL_SPEED;
          break;
        case 99:
          local2 = ItemProperty.SHELL_RADIUS;
          break;
        case 100:
          local2 = ItemProperty.MIN_SHELL_SPEED;
          break;
        case 101:
          local2 = ItemProperty.MAX_SHELL_SPEED;
          break;
        case 102:
          local2 = ItemProperty.SHELL_BOOST_PHASE_DURATION;
          break;
        case 103:
          local2 = ItemProperty.SHELL_SPEEDS_COUNT;
          break;
        case 104:
          local2 = ItemProperty.SHELL_GRAVITY_COEF;
          break;
        case 105:
          local2 = ItemProperty.MAX_RICOCHET_COUNT;
          break;
        case 106:
          local2 = ItemProperty.SECONDARY_WEAPON_KICKBACK;
          break;
        case 107:
          local2 = ItemProperty.SECONDARY_DAMAGE_FROM;
          break;
        case 108:
          local2 = ItemProperty.SECONDARY_DAMAGE_TO;
          break;
        case 109:
          local2 = ItemProperty.HIGHLIGHTING_DISTANCE;
          break;
        case 110:
          local2 = ItemProperty.DRONE_RELOAD;
          break;
        case 111:
          local2 = ItemProperty.DRONE_REPAIR_HEALTH;
          break;
        case 112:
          local2 = ItemProperty.DRONE_REPAIR_RADIUS;
          break;
        case 113:
          local2 = ItemProperty.DRONE_INVENTORY;
          break;
        case 114:
          local2 = ItemProperty.DRONE_INVENTORY_ADD;
          break;
        case 115:
          local2 = ItemProperty.DRONE_BONUS_ADD;
          break;
        case 116:
          local2 = ItemProperty.DRONE_FIRST_AID_BONUS_ADD;
          break;
        case 117:
          local2 = ItemProperty.DRONE_OVERDRIVE_BOOST;
          break;
        case 118:
          local2 = ItemProperty.DRONE_INVENTORY_RADIUS;
          break;
        case 119:
          local2 = ItemProperty.DRONE_COOLDOWN_RADIUS;
          break;
        case 120:
          local2 = ItemProperty.DRONE_DEFEND;
          break;
        case 121:
          local2 = ItemProperty.DRONE_ARMOR_BOOST;
          break;
        case 122:
          local2 = ItemProperty.DRONE_MINE;
          break;
        case 123:
          local2 = ItemProperty.DRONE_ADDITIONAL_MINES;
          break;
        case 124:
          local2 = ItemProperty.DRONE_MINES_ACTIVATION_DELAY;
          break;
        case 125:
          local2 = ItemProperty.DRONE_INVENTORY_COOLDOWN_BOOST;
          break;
        case 126:
          local2 = ItemProperty.DRONE_MINES_PLACEMENT_RADIUS;
          break;
        case 127:
          local2 = ItemProperty.DRONE_POWER_BOOST;
          break;
        case 128:
          local2 = ItemProperty.DRONE_POWER_DURATION;
          break;
        case 129:
          local2 = ItemProperty.DRONE_CRITICAL_HEALTH;
          break;
        case 130:
          local2 = ItemProperty.DRONE_CONSTANT_ARMOR_PERCENT;
          break;
        case 131:
          local2 = ItemProperty.DRONE_CONSTANT_POWER_PERCENT;
          break;
        case 132:
          local2 = ItemProperty.ULTIMATE_HEAL_HP;
          break;
        case 133:
          local2 = ItemProperty.DEVICE_TEMPERATURE_NORMALIZATION;
          break;
        case 134:
          local2 = ItemProperty.DEVICE_BONUS_ENERGY_ON_KILL;
          break;
        case 135:
          local2 = ItemProperty.DEVICE_HEAT_PER_PELLET;
          break;
        case 136:
          local2 = ItemProperty.DEVICE_SMOKY_TEMPERATURE_DELTA_ON_CRITICAL;
          break;
        case 137:
          local2 = ItemProperty.DEVICE_TARGET_HEAT_DELTA_ON_SELF_OVERHEAT;
          break;
        case 138:
          local2 = ItemProperty.ULTIMATE_CHARGE_PER_SEC;
          break;
        case 139:
          local2 = ItemProperty.ULTIMATE_CHARGE_PER_SCORE_POINT;
          break;
        case 140:
          local2 = ItemProperty.ULTIMATE_SCORE_COOLDOWN_SEC;
          break;
        case 141:
          local2 = ItemProperty.ULTIMATE_ACTIVATION_DISCHARGE_PER_SEC;
          break;
        case 142:
          local2 = ItemProperty.GAUSS_AIMED_SHOT_IMPACT;
          break;
        case 143:
          local2 = ItemProperty.GAUSS_AIMED_SPLASH_DAMAGE_RADIUS;
          break;
        case 144:
          local2 = ItemProperty.GAUSS_AIMED_RADIUS_OF_MAX_SPLASH_DAMAGE;
          break;
        case 145:
          local2 = ItemProperty.GAUSS_AIMED_MIN_SPLASH_DAMAGE_PERCENT;
          break;
        case 146:
          local2 = ItemProperty.GAUSS_AIMED_SPLASH_DAMAGE_IMPACT;
          break;
        case 147:
          local2 = ItemProperty.GAUSS_AIMED_RADIUS_OF_FIRST_DIMINUTION_SPLASH_DAMAGE;
          break;
        case 148:
          local2 = ItemProperty.GAUSS_AIMED_FIRST_DIMINUTION_SPLASH_DAMAGE_PERCENT;
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
