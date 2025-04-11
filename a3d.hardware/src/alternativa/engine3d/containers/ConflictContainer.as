package alternativa.engine3d.containers {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;

  use namespace alternativa3d;

  public class ConflictContainer extends Object3DContainer {
    public var resolveByAABB:Boolean = true;
    public var resolveByOOBB:Boolean = true;
    public var threshold:Number = 0.01;

    public function ConflictContainer() {
      super();
    }

    override public function clone() : Object3D {
      var local1:ConflictContainer = new ConflictContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:ConflictContainer = param1 as ConflictContainer;
      this.resolveByAABB = local2.resolveByAABB;
      this.resolveByOOBB = local2.resolveByOOBB;
      this.threshold = local2.threshold;
    }

    override alternativa3d function draw(param1:Camera3D) : void {
      var local2:int = 0;
      var local4:VG = null;
      var local3:VG = alternativa3d::getVG(param1);
      if(local3 != null) {
        if(param1.debug && (local2 = int(param1.alternativa3d::checkInDebug(this))) > 0) {
          if(Boolean(local2 & Debug.BOUNDS)) {
            Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
          }
        }
        if(local3.alternativa3d::next != null) {
          alternativa3d::calculateInverseMatrix();
          if(this.resolveByAABB) {
            local4 = local3;
            while(local4 != null) {
              local4.alternativa3d::calculateAABB(alternativa3d::ima,alternativa3d::imb,alternativa3d::imc,alternativa3d::imd,alternativa3d::ime,alternativa3d::imf,alternativa3d::img,alternativa3d::imh,alternativa3d::imi,alternativa3d::imj,alternativa3d::imk,alternativa3d::iml);
              local4 = local4.alternativa3d::next;
            }
            this.alternativa3d::drawAABBGeometry(param1,local3);
          } else if(this.resolveByOOBB) {
            local4 = local3;
            while(local4 != null) {
              local4.alternativa3d::calculateOOBB(this);
              local4 = local4.alternativa3d::next;
            }
            this.alternativa3d::drawOOBBGeometry(param1,local3);
          } else {
            this.alternativa3d::drawConflictGeometry(param1,local3);
          }
        } else {
          local3.alternativa3d::draw(param1,this.threshold,this);
          local3.alternativa3d::destroy();
        }
      }
    }

    alternativa3d function drawAABBGeometry(param1:Camera3D, param2:VG, param3:Boolean = true, param4:Boolean = false, param5:Boolean = true, param6:int = -1) : void {
      var local7:Boolean = false;
      var local8:Boolean = false;
      var local9:Boolean = false;
      var local14:Boolean = false;
      var local10:VG = param5 ? this.sortGeometry(param2,param3,param4) : param2;
      var local11:VG = local10;
      var local12:VG = local10.alternativa3d::next;
      var local13:Number = Number(local10.alternativa3d::boundMax);
      while(local12 != null) {
        local14 = local12.alternativa3d::boundMin >= local13 - this.threshold;
        if(local14 || local12.alternativa3d::next == null) {
          if(local14) {
            local11.alternativa3d::next = null;
            param6 = 0;
          } else {
            local12 = null;
            param6++;
          }
          if(param3) {
            local7 = alternativa3d::imd < local13;
            local8 = false;
            local9 = true;
          } else if(param4) {
            local7 = alternativa3d::imh < local13;
            local8 = false;
            local9 = false;
          } else {
            local7 = alternativa3d::iml < local13;
            local8 = true;
            local9 = false;
          }
          if(local7) {
            if(local10.alternativa3d::next != null) {
              if(param6 < 2) {
                this.alternativa3d::drawAABBGeometry(param1,local10,local8,local9,true,param6);
              } else if(this.resolveByOOBB) {
                local11 = local10;
                while(local11 != null) {
                  local11.alternativa3d::calculateOOBB(this);
                  local11 = local11.alternativa3d::next;
                }
                this.alternativa3d::drawOOBBGeometry(param1,local10);
              } else {
                this.alternativa3d::drawConflictGeometry(param1,local10);
              }
            } else {
              local10.alternativa3d::draw(param1,this.threshold,this);
              local10.alternativa3d::destroy();
            }
            if(local12 != null) {
              if(local12.alternativa3d::next != null) {
                this.alternativa3d::drawAABBGeometry(param1,local12,param3,param4,false,-1);
              } else {
                local12.alternativa3d::draw(param1,this.threshold,this);
                local12.alternativa3d::destroy();
              }
            }
          } else {
            if(local12 != null) {
              if(local12.alternativa3d::next != null) {
                this.alternativa3d::drawAABBGeometry(param1,local12,param3,param4,false,-1);
              } else {
                local12.alternativa3d::draw(param1,this.threshold,this);
                local12.alternativa3d::destroy();
              }
            }
            if(local10.alternativa3d::next != null) {
              if(param6 < 2) {
                this.alternativa3d::drawAABBGeometry(param1,local10,local8,local9,true,param6);
              } else if(this.resolveByOOBB) {
                local11 = local10;
                while(local11 != null) {
                  local11.alternativa3d::calculateOOBB(this);
                  local11 = local11.alternativa3d::next;
                }
                this.alternativa3d::drawOOBBGeometry(param1,local10);
              } else {
                this.alternativa3d::drawConflictGeometry(param1,local10);
              }
            } else {
              local10.alternativa3d::draw(param1,this.threshold,this);
              local10.alternativa3d::destroy();
            }
          }
          break;
        }
        if(local12.alternativa3d::boundMax > local13) {
          local13 = Number(local12.alternativa3d::boundMax);
        }
        local11 = local12;
        local12 = local12.alternativa3d::next;
      }
    }

    private function sortGeometry(param1:VG, param2:Boolean, param3:Boolean) : VG {
      var local4:VG = param1;
      var local5:VG = param1.alternativa3d::next;
      while(local5 != null && local5.alternativa3d::next != null) {
        param1 = param1.alternativa3d::next;
        local5 = local5.alternativa3d::next.alternativa3d::next;
      }
      local5 = param1.alternativa3d::next;
      param1.alternativa3d::next = null;
      if(local4.alternativa3d::next != null) {
        local4 = this.sortGeometry(local4,param2,param3);
      } else if(param2) {
        local4.alternativa3d::boundMin = local4.alternativa3d::boundMinX;
        local4.alternativa3d::boundMax = local4.alternativa3d::boundMaxX;
      } else if(param3) {
        local4.alternativa3d::boundMin = local4.alternativa3d::boundMinY;
        local4.alternativa3d::boundMax = local4.alternativa3d::boundMaxY;
      } else {
        local4.alternativa3d::boundMin = local4.alternativa3d::boundMinZ;
        local4.alternativa3d::boundMax = local4.alternativa3d::boundMaxZ;
      }
      if(local5.alternativa3d::next != null) {
        local5 = this.sortGeometry(local5,param2,param3);
      } else if(param2) {
        local5.alternativa3d::boundMin = local5.alternativa3d::boundMinX;
        local5.alternativa3d::boundMax = local5.alternativa3d::boundMaxX;
      } else if(param3) {
        local5.alternativa3d::boundMin = local5.alternativa3d::boundMinY;
        local5.alternativa3d::boundMax = local5.alternativa3d::boundMaxY;
      } else {
        local5.alternativa3d::boundMin = local5.alternativa3d::boundMinZ;
        local5.alternativa3d::boundMax = local5.alternativa3d::boundMaxZ;
      }
      var local6:Boolean = local4.alternativa3d::boundMin < local5.alternativa3d::boundMin;
      if(local6) {
        param1 = local4;
        local4 = local4.alternativa3d::next;
      } else {
        param1 = local5;
        local5 = local5.alternativa3d::next;
      }
      var local7:VG = param1;
      while(true) {
        if(local4 == null) {
          local7.alternativa3d::next = local5;
          return param1;
        }
        if(local5 == null) {
          local7.alternativa3d::next = local4;
          return param1;
        }
        if(local6) {
          if(local4.alternativa3d::boundMin < local5.alternativa3d::boundMin) {
            local7 = local4;
            local4 = local4.alternativa3d::next;
          } else {
            local7.alternativa3d::next = local5;
            local7 = local5;
            local5 = local5.alternativa3d::next;
            local6 = false;
          }
        } else if(local5.alternativa3d::boundMin < local4.alternativa3d::boundMin) {
          local7 = local5;
          local5 = local5.alternativa3d::next;
        } else {
          local7.alternativa3d::next = local4;
          local7 = local4;
          local4 = local4.alternativa3d::next;
          local6 = true;
        }
      }
      return null;
    }

    alternativa3d function drawOOBBGeometry(param1:Camera3D, param2:VG) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Wrapper = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Boolean = false;
      var local12:Boolean = false;
      var local13:VG = null;
      var local14:VG = null;
      var local15:Boolean = false;
      var local16:VG = null;
      var local17:VG = null;
      var local18:VG = null;
      var local19:VG = null;
      local13 = param2;
      while(local13 != null) {
        if(local13.alternativa3d::viewAligned) {
          local10 = Number(local13.alternativa3d::object.alternativa3d::ml);
          local14 = param2;
          while(local14 != null) {
            if(!local14.alternativa3d::viewAligned) {
              local11 = false;
              local12 = false;
              local3 = local14.alternativa3d::boundVertexList;
              while(local3 != null) {
                if(local3.alternativa3d::cameraZ > local10) {
                  if(local11) {
                    break;
                  }
                  local12 = true;
                } else {
                  if(local12) {
                    break;
                  }
                  local11 = true;
                }
                local3 = local3.alternativa3d::next;
              }
              if(local3 != null) {
                break;
              }
            }
            local14 = local14.alternativa3d::next;
          }
          if(local14 == null) {
            break;
          }
        } else {
          local4 = local13.alternativa3d::boundPlaneList;
          while(local4 != null) {
            local7 = Number(local4.alternativa3d::cameraX);
            local8 = Number(local4.alternativa3d::cameraY);
            local9 = Number(local4.alternativa3d::cameraZ);
            local10 = Number(local4.alternativa3d::offset);
            local15 = false;
            local14 = param2;
            while(local14 != null) {
              if(local13 != local14) {
                local11 = false;
                local12 = false;
                if(local14.alternativa3d::viewAligned) {
                  local5 = local14.alternativa3d::faceStruct.alternativa3d::wrapper;
                  while(local5 != null) {
                    local3 = local5.alternativa3d::vertex;
                    if(local3.alternativa3d::cameraX * local7 + local3.alternativa3d::cameraY * local8 + local3.alternativa3d::cameraZ * local9 >= local10 - this.threshold) {
                      if(local11) {
                        break;
                      }
                      local15 = true;
                      local12 = true;
                    } else {
                      if(local12) {
                        break;
                      }
                      local11 = true;
                    }
                    local5 = local5.alternativa3d::next;
                  }
                  if(local5 != null) {
                    break;
                  }
                } else {
                  local3 = local14.alternativa3d::boundVertexList;
                  while(local3 != null) {
                    if(local3.alternativa3d::cameraX * local7 + local3.alternativa3d::cameraY * local8 + local3.alternativa3d::cameraZ * local9 >= local10 - this.threshold) {
                      if(local11) {
                        break;
                      }
                      local15 = true;
                      local12 = true;
                    } else {
                      if(local12) {
                        break;
                      }
                      local11 = true;
                    }
                    local3 = local3.alternativa3d::next;
                  }
                  if(local3 != null) {
                    break;
                  }
                }
              }
              local14 = local14.alternativa3d::next;
            }
            if(local14 == null && local15) {
              break;
            }
            local4 = local4.alternativa3d::next;
          }
          if(local4 != null) {
            break;
          }
        }
        local13 = local13.alternativa3d::next;
      }
      if(local13 != null) {
        if(local13.alternativa3d::viewAligned) {
          while(param2 != null) {
            local16 = param2.alternativa3d::next;
            if(param2.alternativa3d::viewAligned) {
              local6 = param2.alternativa3d::object.alternativa3d::ml - local10;
              if(local6 < -this.threshold) {
                param2.alternativa3d::next = local19;
                local19 = param2;
              } else if(local6 > this.threshold) {
                param2.alternativa3d::next = local17;
                local17 = param2;
              } else {
                param2.alternativa3d::next = local18;
                local18 = param2;
              }
            } else {
              local3 = param2.alternativa3d::boundVertexList;
              while(local3 != null) {
                local6 = local3.alternativa3d::cameraZ - local10;
                if(local6 < -this.threshold) {
                  param2.alternativa3d::next = local19;
                  local19 = param2;
                  break;
                }
                if(local6 > this.threshold) {
                  param2.alternativa3d::next = local17;
                  local17 = param2;
                  break;
                }
                local3 = local3.alternativa3d::next;
              }
              if(local3 == null) {
                param2.alternativa3d::next = local18;
                local18 = param2;
              }
            }
            param2 = local16;
          }
        } else {
          while(param2 != null) {
            local16 = param2.alternativa3d::next;
            if(param2.alternativa3d::viewAligned) {
              local5 = param2.alternativa3d::faceStruct.alternativa3d::wrapper;
              while(local5 != null) {
                local3 = local5.alternativa3d::vertex;
                local6 = local3.alternativa3d::cameraX * local7 + local3.alternativa3d::cameraY * local8 + local3.alternativa3d::cameraZ * local9 - local10;
                if(local6 < -this.threshold) {
                  param2.alternativa3d::next = local17;
                  local17 = param2;
                  break;
                }
                if(local6 > this.threshold) {
                  param2.alternativa3d::next = local19;
                  local19 = param2;
                  break;
                }
                local5 = local5.alternativa3d::next;
              }
              if(local5 == null) {
                param2.alternativa3d::next = local18;
                local18 = param2;
              }
            } else {
              local3 = param2.alternativa3d::boundVertexList;
              while(local3 != null) {
                local6 = local3.alternativa3d::cameraX * local7 + local3.alternativa3d::cameraY * local8 + local3.alternativa3d::cameraZ * local9 - local10;
                if(local6 < -this.threshold) {
                  param2.alternativa3d::next = local17;
                  local17 = param2;
                  break;
                }
                if(local6 > this.threshold) {
                  param2.alternativa3d::next = local19;
                  local19 = param2;
                  break;
                }
                local3 = local3.alternativa3d::next;
              }
              if(local3 == null) {
                param2.alternativa3d::next = local18;
                local18 = param2;
              }
            }
            param2 = local16;
          }
        }
        if(Boolean(local13.alternativa3d::viewAligned) || local10 < 0) {
          if(local19 != null) {
            if(local19.alternativa3d::next != null) {
              this.alternativa3d::drawOOBBGeometry(param1,local19);
            } else {
              local19.alternativa3d::draw(param1,this.threshold,this);
              local19.alternativa3d::destroy();
            }
          }
          while(local18 != null) {
            local16 = local18.alternativa3d::next;
            local18.alternativa3d::draw(param1,this.threshold,this);
            local18.alternativa3d::destroy();
            local18 = local16;
          }
          if(local17 != null) {
            if(local17.alternativa3d::next != null) {
              this.alternativa3d::drawOOBBGeometry(param1,local17);
            } else {
              local17.alternativa3d::draw(param1,this.threshold,this);
              local17.alternativa3d::destroy();
            }
          }
        } else {
          if(local17 != null) {
            if(local17.alternativa3d::next != null) {
              this.alternativa3d::drawOOBBGeometry(param1,local17);
            } else {
              local17.alternativa3d::draw(param1,this.threshold,this);
              local17.alternativa3d::destroy();
            }
          }
          while(local18 != null) {
            local16 = local18.alternativa3d::next;
            local18.alternativa3d::draw(param1,this.threshold,this);
            local18.alternativa3d::destroy();
            local18 = local16;
          }
          if(local19 != null) {
            if(local19.alternativa3d::next != null) {
              this.alternativa3d::drawOOBBGeometry(param1,local19);
            } else {
              local19.alternativa3d::draw(param1,this.threshold,this);
              local19.alternativa3d::destroy();
            }
          }
        }
      } else {
        this.alternativa3d::drawConflictGeometry(param1,param2);
      }
    }

    alternativa3d function drawConflictGeometry(param1:Camera3D, param2:VG) : void {
      var local3:Face = null;
      var local4:Face = null;
      var local5:VG = null;
      var local6:VG = null;
      var local7:VG = null;
      var local8:Face = null;
      var local9:Face = null;
      var local10:Face = null;
      var local11:Face = null;
      var local12:Face = null;
      var local13:Face = null;
      var local14:Face = null;
      var local15:Face = null;
      var local16:Face = null;
      var local17:Boolean = false;
      while(param2 != null) {
        local5 = param2.alternativa3d::next;
        if(param2.alternativa3d::space == 1) {
          param2.alternativa3d::transformStruct(param2.alternativa3d::faceStruct,++param2.alternativa3d::object.alternativa3d::transformId,alternativa3d::ma,alternativa3d::mb,alternativa3d::mc,alternativa3d::md,alternativa3d::me,alternativa3d::mf,alternativa3d::mg,alternativa3d::mh,alternativa3d::mi,alternativa3d::mj,alternativa3d::mk,alternativa3d::ml);
        }
        if(param2.alternativa3d::sorting == 3) {
          param2.alternativa3d::next = local6;
          local6 = param2;
        } else {
          if(param2.alternativa3d::sorting == 2) {
            if(local8 != null) {
              local9.alternativa3d::processNext = param2.alternativa3d::faceStruct;
            } else {
              local8 = param2.alternativa3d::faceStruct;
            }
            local9 = param2.alternativa3d::faceStruct;
            local9.alternativa3d::geometry = param2;
            while(local9.alternativa3d::processNext != null) {
              local9 = local9.alternativa3d::processNext;
              local9.alternativa3d::geometry = param2;
            }
          } else {
            if(local10 != null) {
              local11.alternativa3d::processNext = param2.alternativa3d::faceStruct;
            } else {
              local10 = param2.alternativa3d::faceStruct;
            }
            local11 = param2.alternativa3d::faceStruct;
            local11.alternativa3d::geometry = param2;
            while(local11.alternativa3d::processNext != null) {
              local11 = local11.alternativa3d::processNext;
              local11.alternativa3d::geometry = param2;
            }
          }
          param2.alternativa3d::faceStruct = null;
          param2.alternativa3d::next = local7;
          local7 = param2;
        }
        param2 = local5;
      }
      if(local7 != null) {
        param2 = local7;
        while(param2.alternativa3d::next != null) {
          param2 = param2.alternativa3d::next;
        }
        param2.alternativa3d::next = local6;
      } else {
        local7 = local6;
      }
      if(local8 != null) {
        local12 = local8;
        local9.alternativa3d::processNext = local10;
      } else {
        local12 = local10;
      }
      if(local6 != null) {
        local6.alternativa3d::faceStruct.alternativa3d::geometry = local6;
        local12 = this.collectNode(local6.alternativa3d::faceStruct,local12,param1,this.threshold,true);
        local6.alternativa3d::faceStruct = null;
        local6 = local6.alternativa3d::next;
        while(local6 != null) {
          local6.alternativa3d::faceStruct.alternativa3d::geometry = local6;
          local12 = this.collectNode(local6.alternativa3d::faceStruct,local12,param1,this.threshold,false);
          local6.alternativa3d::faceStruct = null;
          local6 = local6.alternativa3d::next;
        }
      } else if(local8 != null) {
        local12 = this.collectNode(null,local12,param1,this.threshold,true);
      } else if(local10 != null) {
        local12 = param1.alternativa3d::sortByAverageZ(local12);
      }
      local3 = local12;
      while(local3 != null) {
        local4 = local3.alternativa3d::processNext;
        param2 = local3.alternativa3d::geometry;
        local3.alternativa3d::geometry = null;
        local17 = local4 == null || param2 != local4.alternativa3d::geometry;
        if(local17 || local3.material != local4.material) {
          local3.alternativa3d::processNext = null;
          if(local17) {
            if(local13 != null) {
              local14.alternativa3d::processNegative = local12;
              local13 = null;
              local14 = null;
            } else {
              local12.alternativa3d::processPositive = local15;
              local15 = local12;
              local15.alternativa3d::geometry = param2;
            }
          } else {
            if(local13 != null) {
              local14.alternativa3d::processNegative = local12;
            } else {
              local12.alternativa3d::processPositive = local15;
              local15 = local12;
              local15.alternativa3d::geometry = param2;
              local13 = local12;
            }
            local14 = local12;
          }
          local12 = local4;
        }
        local3 = local4;
      }
      if(param1.debug) {
        local12 = local15;
        while(local12 != null) {
          if(Boolean(local12.alternativa3d::geometry.alternativa3d::debug & Debug.EDGES)) {
            local3 = local12;
            while(local3 != null) {
              Debug.alternativa3d::drawEdges(param1,local3,16711680);
              local3 = local3.alternativa3d::processNegative;
            }
          }
          local12 = local12.alternativa3d::processPositive;
        }
      }
      while(local15 != null) {
        local12 = local15;
        local15 = local12.alternativa3d::processPositive;
        local12.alternativa3d::processPositive = null;
        param2 = local12.alternativa3d::geometry;
        local12.alternativa3d::geometry = null;
        local16 = null;
        while(local12 != null) {
          local4 = local12.alternativa3d::processNegative;
          if(local12.material != null) {
            local12.alternativa3d::processNegative = local16;
            local16 = local12;
          } else {
            local12.alternativa3d::processNegative = null;
            while(local12 != null) {
              local3 = local12.alternativa3d::processNext;
              local12.alternativa3d::processNext = null;
              local12 = local3;
            }
          }
          local12 = local4;
        }
        local12 = local16;
        while(local12 != null) {
          local4 = local12.alternativa3d::processNegative;
          local12.alternativa3d::processNegative = null;
          param1.alternativa3d::addTransparent(local12,param2.alternativa3d::object);
          local12 = local4;
        }
      }
      param2 = local7;
      while(param2 != null) {
        local5 = param2.alternativa3d::next;
        param2.alternativa3d::destroy();
        param2 = local5;
      }
    }

    private function collectNode(param1:Face, param2:Face, param3:Camera3D, param4:Number, param5:Boolean, param6:Face = null) : Face {
      var local7:Wrapper = null;
      var local8:Vertex = null;
      var local9:Vertex = null;
      var local10:Vertex = null;
      var local11:Vertex = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Face = null;
      var local17:Face = null;
      var local18:Face = null;
      var local19:VG = null;
      var local22:Face = null;
      var local23:Face = null;
      var local24:Face = null;
      var local25:Face = null;
      var local26:Face = null;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Number = NaN;
      var local38:Number = NaN;
      var local39:Number = NaN;
      var local40:Number = NaN;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:Number = NaN;
      var local45:Boolean = false;
      var local46:Boolean = false;
      var local47:Number = NaN;
      var local48:Face = null;
      var local49:Face = null;
      var local50:Wrapper = null;
      var local51:Wrapper = null;
      var local52:Wrapper = null;
      var local53:Boolean = false;
      var local54:Number = NaN;
      if(param1 != null) {
        local19 = param1.alternativa3d::geometry;
        if(param1.alternativa3d::offset < 0) {
          local17 = param1.alternativa3d::processNegative;
          local18 = param1.alternativa3d::processPositive;
          local12 = Number(param1.alternativa3d::normalX);
          local13 = Number(param1.alternativa3d::normalY);
          local14 = Number(param1.alternativa3d::normalZ);
          local15 = Number(param1.alternativa3d::offset);
        } else {
          local17 = param1.alternativa3d::processPositive;
          local18 = param1.alternativa3d::processNegative;
          local12 = -param1.alternativa3d::normalX;
          local13 = -param1.alternativa3d::normalY;
          local14 = -param1.alternativa3d::normalZ;
          local15 = -param1.alternativa3d::offset;
        }
        param1.alternativa3d::processNegative = null;
        param1.alternativa3d::processPositive = null;
        if(param1.alternativa3d::wrapper != null) {
          local16 = param1;
          while(local16.alternativa3d::processNext != null) {
            local16 = local16.alternativa3d::processNext;
            local16.alternativa3d::geometry = local19;
          }
        } else {
          param1.alternativa3d::geometry = null;
          param1 = null;
        }
      } else {
        param1 = param2;
        param2 = param1.alternativa3d::processNext;
        local16 = param1;
        local7 = param1.alternativa3d::wrapper;
        local8 = local7.alternativa3d::vertex;
        local7 = local7.alternativa3d::next;
        local9 = local7.alternativa3d::vertex;
        local28 = Number(local8.alternativa3d::cameraX);
        local29 = Number(local8.alternativa3d::cameraY);
        local30 = Number(local8.alternativa3d::cameraZ);
        local31 = local9.alternativa3d::cameraX - local28;
        local32 = local9.alternativa3d::cameraY - local29;
        local33 = local9.alternativa3d::cameraZ - local30;
        local12 = 0;
        local13 = 0;
        local14 = 1;
        local15 = local30;
        local34 = 0;
        local7 = local7.alternativa3d::next;
        while(local7 != null) {
          local11 = local7.alternativa3d::vertex;
          local35 = local11.alternativa3d::cameraX - local28;
          local36 = local11.alternativa3d::cameraY - local29;
          local37 = local11.alternativa3d::cameraZ - local30;
          local38 = local37 * local32 - local36 * local33;
          local39 = local35 * local33 - local37 * local31;
          local40 = local36 * local31 - local35 * local32;
          local41 = local38 * local38 + local39 * local39 + local40 * local40;
          if(local41 > param4) {
            local41 = 1 / Math.sqrt(local41);
            local12 = local38 * local41;
            local13 = local39 * local41;
            local14 = local40 * local41;
            local15 = local28 * local12 + local29 * local13 + local30 * local14;
            break;
          }
          if(local41 > local34) {
            local41 = 1 / Math.sqrt(local41);
            local12 = local38 * local41;
            local13 = local39 * local41;
            local14 = local40 * local41;
            local15 = local28 * local12 + local29 * local13 + local30 * local14;
            local34 = local41;
          }
          local7 = local7.alternativa3d::next;
        }
      }
      var local20:Number = local15 - param4;
      var local21:Number = local15 + param4;
      var local27:Face = param2;
      while(local27 != null) {
        local26 = local27.alternativa3d::processNext;
        local7 = local27.alternativa3d::wrapper;
        local8 = local7.alternativa3d::vertex;
        local7 = local7.alternativa3d::next;
        local9 = local7.alternativa3d::vertex;
        local7 = local7.alternativa3d::next;
        local10 = local7.alternativa3d::vertex;
        local7 = local7.alternativa3d::next;
        local42 = local8.alternativa3d::cameraX * local12 + local8.alternativa3d::cameraY * local13 + local8.alternativa3d::cameraZ * local14;
        local43 = local9.alternativa3d::cameraX * local12 + local9.alternativa3d::cameraY * local13 + local9.alternativa3d::cameraZ * local14;
        local44 = local10.alternativa3d::cameraX * local12 + local10.alternativa3d::cameraY * local13 + local10.alternativa3d::cameraZ * local14;
        local45 = local42 < local20 || local43 < local20 || local44 < local20;
        local46 = local42 > local21 || local43 > local21 || local44 > local21;
        while(local7 != null) {
          local11 = local7.alternativa3d::vertex;
          local47 = local11.alternativa3d::cameraX * local12 + local11.alternativa3d::cameraY * local13 + local11.alternativa3d::cameraZ * local14;
          if(local47 < local20) {
            local45 = true;
          } else if(local47 > local21) {
            local46 = true;
          }
          local11.alternativa3d::offset = local47;
          local7 = local7.alternativa3d::next;
        }
        if(!local45) {
          if(!local46) {
            if(param1 != null) {
              local16.alternativa3d::processNext = local27;
            } else {
              param1 = local27;
            }
            local16 = local27;
          } else {
            if(local24 != null) {
              local25.alternativa3d::processNext = local27;
            } else {
              local24 = local27;
            }
            local25 = local27;
          }
        } else if(!local46) {
          if(local22 != null) {
            local23.alternativa3d::processNext = local27;
          } else {
            local22 = local27;
          }
          local23 = local27;
        } else {
          local8.alternativa3d::offset = local42;
          local9.alternativa3d::offset = local43;
          local10.alternativa3d::offset = local44;
          local48 = local27.alternativa3d::create();
          local48.material = local27.material;
          local48.alternativa3d::geometry = local27.alternativa3d::geometry;
          param3.alternativa3d::lastFace.alternativa3d::next = local48;
          param3.alternativa3d::lastFace = local48;
          local49 = local27.alternativa3d::create();
          local49.material = local27.material;
          local49.alternativa3d::geometry = local27.alternativa3d::geometry;
          param3.alternativa3d::lastFace.alternativa3d::next = local49;
          param3.alternativa3d::lastFace = local49;
          local50 = null;
          local51 = null;
          local7 = local27.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
          while(local7.alternativa3d::next != null) {
            local7 = local7.alternativa3d::next;
          }
          local8 = local7.alternativa3d::vertex;
          local42 = Number(local8.alternativa3d::offset);
          local53 = local27.material != null && Boolean(local27.material.alternativa3d::useVerticesNormals);
          local7 = local27.alternativa3d::wrapper;
          while(local7 != null) {
            local9 = local7.alternativa3d::vertex;
            local43 = Number(local9.alternativa3d::offset);
            if(local42 < local20 && local43 > local21 || local42 > local21 && local43 < local20) {
              local54 = (local15 - local42) / (local43 - local42);
              local11 = local9.alternativa3d::create();
              param3.alternativa3d::lastVertex.alternativa3d::next = local11;
              param3.alternativa3d::lastVertex = local11;
              local11.alternativa3d::cameraX = local8.alternativa3d::cameraX + (local9.alternativa3d::cameraX - local8.alternativa3d::cameraX) * local54;
              local11.alternativa3d::cameraY = local8.alternativa3d::cameraY + (local9.alternativa3d::cameraY - local8.alternativa3d::cameraY) * local54;
              local11.alternativa3d::cameraZ = local8.alternativa3d::cameraZ + (local9.alternativa3d::cameraZ - local8.alternativa3d::cameraZ) * local54;
              local11.u = local8.u + (local9.u - local8.u) * local54;
              local11.v = local8.v + (local9.v - local8.v) * local54;
              if(local53) {
                local11.x = local8.x + (local9.x - local8.x) * local54;
                local11.y = local8.y + (local9.y - local8.y) * local54;
                local11.z = local8.z + (local9.z - local8.z) * local54;
                local11.normalX = local8.normalX + (local9.normalX - local8.normalX) * local54;
                local11.normalY = local8.normalY + (local9.normalY - local8.normalY) * local54;
                local11.normalZ = local8.normalZ + (local9.normalZ - local8.normalZ) * local54;
              }
              local52 = local7.alternativa3d::create();
              local52.alternativa3d::vertex = local11;
              if(local50 != null) {
                local50.alternativa3d::next = local52;
              } else {
                local48.alternativa3d::wrapper = local52;
              }
              local50 = local52;
              local52 = local7.alternativa3d::create();
              local52.alternativa3d::vertex = local11;
              if(local51 != null) {
                local51.alternativa3d::next = local52;
              } else {
                local49.alternativa3d::wrapper = local52;
              }
              local51 = local52;
            }
            if(local43 <= local21) {
              local52 = local7.alternativa3d::create();
              local52.alternativa3d::vertex = local9;
              if(local50 != null) {
                local50.alternativa3d::next = local52;
              } else {
                local48.alternativa3d::wrapper = local52;
              }
              local50 = local52;
            }
            if(local43 >= local20) {
              local52 = local7.alternativa3d::create();
              local52.alternativa3d::vertex = local9;
              if(local51 != null) {
                local51.alternativa3d::next = local52;
              } else {
                local49.alternativa3d::wrapper = local52;
              }
              local51 = local52;
            }
            local8 = local9;
            local42 = local43;
            local7 = local7.alternativa3d::next;
          }
          if(local22 != null) {
            local23.alternativa3d::processNext = local48;
          } else {
            local22 = local48;
          }
          local23 = local48;
          if(local24 != null) {
            local25.alternativa3d::processNext = local49;
          } else {
            local24 = local49;
          }
          local25 = local49;
          local27.alternativa3d::processNext = null;
          local27.alternativa3d::geometry = null;
        }
        local27 = local26;
      }
      if(local18 != null) {
        local18.alternativa3d::geometry = local19;
        if(local25 != null) {
          local25.alternativa3d::processNext = null;
        }
        param6 = this.collectNode(local18,local24,param3,param4,param5,param6);
      } else if(local24 != null) {
        if(param5 && local24 != local25) {
          if(local25 != null) {
            local25.alternativa3d::processNext = null;
          }
          if(local24.alternativa3d::geometry.alternativa3d::sorting == 2) {
            param6 = this.collectNode(null,local24,param3,param4,param5,param6);
          } else {
            local24 = param3.alternativa3d::sortByAverageZ(local24);
            local25 = local24.alternativa3d::processNext;
            while(local25.alternativa3d::processNext != null) {
              local25 = local25.alternativa3d::processNext;
            }
            local25.alternativa3d::processNext = param6;
            param6 = local24;
          }
        } else {
          local25.alternativa3d::processNext = param6;
          param6 = local24;
        }
      }
      if(param1 != null) {
        local16.alternativa3d::processNext = param6;
        param6 = param1;
      }
      if(local17 != null) {
        local17.alternativa3d::geometry = local19;
        if(local23 != null) {
          local23.alternativa3d::processNext = null;
        }
        param6 = this.collectNode(local17,local22,param3,param4,param5,param6);
      } else if(local22 != null) {
        if(param5 && local22 != local23) {
          if(local23 != null) {
            local23.alternativa3d::processNext = null;
          }
          if(local22.alternativa3d::geometry.alternativa3d::sorting == 2) {
            param6 = this.collectNode(null,local22,param3,param4,param5,param6);
          } else {
            local22 = param3.alternativa3d::sortByAverageZ(local22);
            local23 = local22.alternativa3d::processNext;
            while(local23.alternativa3d::processNext != null) {
              local23 = local23.alternativa3d::processNext;
            }
            local23.alternativa3d::processNext = param6;
            param6 = local22;
          }
        } else {
          local23.alternativa3d::processNext = param6;
          param6 = local22;
        }
      }
      return param6;
    }
  }
}
