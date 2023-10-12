
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

weapon_granting_device := class(creative_device):

    @editable Button : conditional_button_device = conditional_button_device{}
    @editable Granter : item_granter_device = item_granter_device{}

    OnBegin<override>()<suspends>:void=
        Button.ActivatedEvent.Subscribe(GiveItem)

    GiveItem(Agent : agent) : void =
        Granter.GrantItem(Agent)

        