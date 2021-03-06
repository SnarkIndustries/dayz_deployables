if (isDedicated) then {
	"pvDeployables" addPublicVariableEventHandler {
		private ["_mode","_player","_object","_target"];
		_mode = (_this select 1) select 0;
		_player = (_this select 1) select 1;
		_target = (_this select 1) select 2;

		switch (_mode) do {
			case 0: {
				//Delete vehicle
				deleteVehicle _target;
			};
			case 1: {
				//Unpack old bike
				_object = createVehicle ["Old_bike_TK_CIV_EP1", (getPosATL _player), [], 0, "NONE"];
				_object setVariable ["ObjectID",""];
				_object setVariable ["DZAI",1];
				_object setDir (getDir _player);
				_object setPosATL (_player modelToWorld [0,1.5,0]);
				_player reveal _object;
			};
			case 2: {
				//Return parts.
				switch (_target) do {
					case "TT650_Civ": {
						_object = createVehicle ["WeaponHolder", (getPosATL _player), [], 0, "NONE"];
						_object addMagazineCargoGlobal ["PartGeneric", 1]; 
						_object addMagazineCargoGlobal ["PartEngine", 1];
						_object setPosATL (getPosATL _player);
					};
					case "CSJ_GyroC": {
						_object = createVehicle ["WeaponHolder", (getPosATL _player), [], 0, "NONE"];
						_object addMagazineCargoGlobal ["PartGeneric", 1]; 
						_object addMagazineCargoGlobal ["PartVRotor", 1];
						_object setPosATL (getPosATL _player);
					};
					case default {};
				};
			};
			case 3: {
				//Upgrade to motorbike
				_object = createVehicle ["TT650_Civ", (_target select 0), [], 0, "NONE"];
				_object setVariable ["ObjectID",""];
				_object setVariable ["DZAI",1];
				_object setFuel 0.4;
				_object setDamage (_target select 2);
				_object setDir (_target select 1);
				_object setPosATL (_target select 0);
				_player reveal _object;
			};
			case 5: {
				//Unpack gyrocopter
				_object = createVehicle ["CSJ_GyroC", (_target select 0), [], 0, "NONE"];
				_object setVariable ["ObjectID",""];
				_object setVariable ["DZAI",1];
				_object setFuel (_target select 3);
				_object setDamage (_target select 2);
				_object setDir (_target select 1);
				_object setPosATL (_target select 0);
				_player reveal _object;

			};
		};
		pvDeployables = [];
	};
} else {
	_nul = [] spawn {
		waitUntil {!isNil "fnc_usec_selfActions"};
		fnc_usec_selfActions = compile preprocessFileLineNumbers "custom\fn_selfActions.sqf";
	};
};