require 'rails_helper'

RSpec.describe Switch, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "Model validations:" do
    context "The Switch" do
        before :each do
          @switch = build :switch

        end

        it "is consistent." do
          expect(@switch).to be_valid(Switch)
        end

        it "can be save." do
          expect{
            @switch.save
          }.to change {Switch.count}.by 1
        end

    end



    context "The Switch" do

      before :each do

        @switch_missing_uuid = build :inv_switch_missing_uuid
        @switch_different_id_and_uuid = build :inv_switch_different_id_and_uuid
        @switch_missing_property = build :inv_switch_missing_property

        #Testing properties values that have a predefined list of values.
          @switch_with_invalid_accessState = build :inv_switch_invalid_accessState
        @switch_with_invalid_backedBy = build :inv_switch_invalid_backedBy
        @switch_with_invalid_cmmHealthState =  build :inv_switch_invalid_cmmHealthState
        @switch_with_invalid_excludedHealthState = build :inv_switch_invalid_excludedHealthState
        @switch_with_invalid_overallHealthState = build :inv_switch_invalid_overallHealthState
        @switch_with_invalid_panicDump = buil :inv_switch_invalid_panicDump
        @switch_with_invalid_powerState = buil :inv_switch_invalid_powerState
        @switch_with_invalid_protectedMode = buil :inv_switch_invalid_protectedMode
        @switch_with_invalid_savePending = buil :inv_switch_invalid_savePending
        @switch_with_invalid_stackedMode = buil :inv_switch_invalid_stackedMode


        #Testing type of property
        @switch_with_invalid_applyPending_type = build :inv_switch_with_invalid_applyPending_type
        @switch_with_invalid_attachedNodes_type = build :inv_switch_with_invalid_attachedNodes_type
        @switch_with_invalid_cmmDisplayName_type = build :inv_switch_with_invalid_cmmDisplayName_type
        @switch_with_invalid_contact_type = build :inv_switch_with_invalid_contact_type
        @switch_with_invalid_cpuUtilization_type = build :inv_switch_with_invalid_cpuUtilization_type
        @switch_with_invalid_dataHandle_type = build :inv_switch_with_invalid_dataHandle_type
        @switch_with_description_dataHandle_type = build :inv_switch_with_invalid_description_type
        @switch_with_invalid_dnsHostnames_type = build :inv_switch_with_invalid_dnsHostnames_type
        @switch_with_invalid_domainName_type = build :inv_switch_with_invalid_domainName_type
        @switch_with_invalid_entitleSerialNumber_type = build :inv_switch_with_invalid_entitleSerialNumber_type
        @switch_with_invalid_fans_type = build :inv_switch_with_invalid_fans_type
        @switch_with_invalid_firmware_type = build :inv_switch_with_invalid_firmware_type
        @switch_with_invalid_FRU_type = build :inv_switch_with_invalid_FRU_type
        @switch_with_invalid_fruSerialNumber_type = build :inv_switch_with_invalid_fruSerialNumber_type
        @switch_with_invalid_hostname_type = build :inv_switch_with_invalid_hostnameddress_type
        @switch_with_invalid_ipv6Address_type = build :inv_switch_with_invalid_ipv6Address_type
        @switch_with_invalid_leds_type = build :inv_switch_with_invalid_leds_type
        @switch_with_invalid_macAddress_type = build :inv_switch_with_invalid_macAddress_type
        @switch_with_invalid_machineType_type = build :inv_switch_with_invalid_machineType_type
        @switch_with_invalid_manufacturer_type = build :inv_switch_with_invalid_manufacturer_type
        @switch_with_invalid_manufacturerID_type = build :inv_switch_with_invalid_manufacturerID_type
        @switch_with_invalid_manufacturingDate_type = build :inv_switch_with_invalid_manufacturingDate_type
        @switch_with_invalid_memoryUtilization_type = build :inv_switch_with_invalid_memoryUtilization_type
        @switch_with_invalid_model_type = build :inv_switch_with_invalid_model_type
        @switch_with_invalid_panicDump_type = build :inv_switch_with_invalid_panicDump_type
        @switch_with_invalid_ports_type = build :inv_switch_with_invalid_ports_type
        @switch_with_invalid_productID_type = build :inv_switch_with_invalid_productID_type
        @switch_with_invalid_productName_type = build   :inv_switch_with_invalid_productName_type
        @switch_with_invalid_resetReason_type = build :inv_switch_with_invalid_resetReason_type
        @switch_with_invalid_serialNumber_type = build :inv_switch_with_invalid_serialNumber_type
        @switch_with_invalid_slots_type = build :inv_switch_with_invalid_slots_type
        @switch_with_invalid_sysObjectID_type = build :inv_switch_with_invalid_sysObjectID_type
        @switch_with_invalid_temperatureSensors_type = build :inv_switch_with_invalid_temperatureSensors_type
        @switch_with_invalid_type_type = build :inv_switch_with_invalid_type_type
        @switch_with_invalid_upTime_type = build :inv_switch_with_invalid_upTime_type
        @switch_with_invalid_uri_type = build :inv_switch_with_invalid_uri_type
        @switch_with_invalid_userDescription_type = build :inv_switch_with_invalid_userDescription_type
        @switch_with_invalid_uuid_type = build :inv_switch_with_invalid_uuid_type
        @switch_with_invalid_vpdID_type = build :inv_switch_with_invalid_vpdID_type

      end

      context "is invalid" do
          it "if has no uuid in properties" do
            expect(@switch_hasnt_uuid).to_not be_valid(Switch)
          end

          it "if _id is different from properties.uuid" do
            expect(@switch_different_id_and_uuid).to_not be_valid(Switch)
          end

          it "if some property is missing" do
            expect(@switch_missing_property).to_not be_valid(Switch)
          end



          it "if accessState is not in a predefined list" do
              expect(@switch_with_invalid_accessState).to_not be_valid(Switch)
          end

          it "if backedBy is not in a predefined list" do
              expect(@switch_with_invalid_backedBy).to_not be_valid(Switch)
          end

          it "if cmmHealthState is not in a predefined list" do
              expect(@switch_with_invalid_cmmHealthState).to_not be_valid(Switch)
          end


          it "if excludedHealthState is not in a predefined list" do
              expect(@switch_with_invalid_excludedHealthState).to_not be_valid(Switch)
          end

          it "if overallHealthState is not in a predefined list" do
              expect(@switch_with_invalid_overallHealthState).to_not be_valid(Switch)
          end

          it "if panicDump is not in a predefined list" do
              expect(@switch_with_invalid_panicDump).to_not be_valid(Switch)
          end

          it "if powerState is not in a predefined list" do
              expect(@switch_with_invalid_powerState).to_not be_valid(Switch)
          end

          it "if protectedMode is not in a predefined list" do
              expect(@switch_with_invalid_protectedMode).to_not be_valid(Switch)
          end

          it "if savePending is not in a predefined list" do
              expect(@switch_with_invalid_savePending).to_not be_valid(Switch)
          end

          it "if stackedMode is not in a predefined list" do
              expect(@switch_with_invalid_stackedMode).to_not be_valid(Switch)
          end

      end






    end


  end

end
