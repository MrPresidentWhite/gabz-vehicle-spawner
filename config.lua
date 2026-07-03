Config = {}

-- Language: 'de' or 'en' (see locales/ folder)
Config.Locale = 'de'

-- Keybind to open the menu (default: F7)
-- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'F7'

-- Chat command to open the menu
Config.Command = 'gabzvehicles'

-- Ace permission for the spawner
-- Example in server.cfg: add_ace group.admin gabzvehicles.spawn allow
Config.AcePermission = 'gabzvehicles.spawn'

-- If true, players need the ace permission. If false, everyone can spawn.
Config.RequirePermission = false

-- Delete the previous vehicle when spawning a new one
Config.DeletePreviousVehicle = true

-- Warp the player into the spawned vehicle
Config.WarpIntoVehicle = true

-- Fully repair and upgrade the spawned vehicle
Config.MaxUpgrade = false

-- Spawn distance in front of the player (in meters)
Config.SpawnDistance = 3.0

-- Category order in the menu
Config.CategoryOrder = {
    'Super',
    'Sports',
    'Sports Classic',
    'Sedans',
    'Muscle',
    'Compacts',
    'Coupes',
    'SUV',
    'Offroad',
    'Vans',
    'Commercial',
    'Service',
    'Emergency',
}

-- Vehicle spawn codes and metadata from GabZ Vehicle Data
-- Source: https://github.com/JustBlueDolphin/Gabz-Vehicle-Data
-- Thank you to JustBlueDolphin for providing this data
Config.Vehicles = {
    -- Super
    { model = 'gb811s2',         brand = 'Pfister',              name = '811 S2',               category = 'Super' },
    { model = 'gbbanshees',      brand = 'Bravado',              name = 'Banshee S',            category = 'Super' },
    { model = 'gbemerussb1',     brand = 'Progen',               name = 'Emerus SB1',           category = 'Super' },
    { model = 'gbprospero',      brand = 'Pegassi',              name = 'Prospero',             category = 'Super' },
    { model = 'gbtr3s',          brand = 'Progen',               name = 'TR3-S',                category = 'Super' },
    { model = 'gbcheetahs',      brand = 'Grotti',               name = 'Grotti Cheetah S',     category = 'Super' },
    { model = 'gbmugello',       brand = 'Grotti',               name = 'Mugello',              category = 'Super' },
    { model = 'gbtempestafs',    brand = 'Pegassi',              name = 'Tempesta Fuoristrada', category = 'Super' },
    { model = 'gbzeitgeist',     brand = 'Benefactor-Progen',    name = 'Zeitgeist',            category = 'Super' },

    -- Sedans
    { model = 'gbadmiral',       brand = 'Dundreary',            name = 'Admiral',              category = 'Sedans' },
    { model = 'gbargento7f',     brand = 'Obey',                 name = 'Argento 7F',           category = 'Sedans' },
    { model = 'gbharmann',       brand = 'Benefactor',           name = 'Harmann',              category = 'Sedans' },
    { model = 'gbimpaler',       brand = 'Declasse',             name = 'Imapaler',             category = 'Sedans' },
    { model = 'gbstanierle',     brand = 'Vapid',                name = 'Stainer LE',           category = 'Sedans' },
    { model = 'gbhedra',         brand = 'Vulcar',               name = 'Hedra',                category = 'Sedans' },
    { model = 'gbhedrakombi',    brand = 'Vulcar',               name = 'Hedra Kombi',          category = 'Sedans' },

    -- Sports
    { model = 'gbcomets2r',      brand = 'Pfister',              name = 'Comet S2R',            category = 'Sports' },
    { model = 'gbcomets2rc',     brand = 'Pfister',              name = 'Comet S2R C',          category = 'Sports' },
    { model = 'gbeon',           brand = 'Coil',                 name = 'Eon',                  category = 'Sports' },
    { model = 'gbmilano',        brand = 'Grotti',               name = 'Milano',               category = 'Sports' },
    { model = 'gbmogulrs',       brand = 'Karin',                name = 'Mogul RS',             category = 'Sports' },
    { model = 'gbneonct',        brand = 'Pfister',              name = 'Neon CT',              category = 'Sports' },
    { model = 'gbnexusrr',       brand = 'Dinka',                name = 'Nesus RR',             category = 'Sports' },
    { model = 'gbronin',         brand = 'Emperor',              name = 'Ronin',                category = 'Sports' },
    { model = 'gbschlagenr',     brand = 'Benefactor',           name = 'Schlagen-R',           category = 'Sports' },
    { model = 'gbschlagensp',    brand = 'Benefactor',           name = 'Schlagen-SP',          category = 'Sports' },
    { model = 'gbschrauber',     brand = 'Benefactor',           name = 'Schrauber',            category = 'Sports' },
    { model = 'gbschwartzers',   brand = 'Benefactor',           name = 'Schwartzer S',         category = 'Sports' },
    { model = 'gbsentinelgts',   brand = 'Ubermacht',            name = 'Sentinel GTS',         category = 'Sports' },
    { model = 'gbsolace',        brand = 'Dewbauchee',           name = 'Solace',               category = 'Sports' },
    { model = 'gbsolacev',       brand = 'Dewbauchee',           name = 'Solace Vitesse',       category = 'Sports' },
    { model = 'gbsultanrsx',     brand = 'Karin',                name = 'Sultan RSX',           category = 'Sports' },
    { model = 'gbtenfr',         brand = 'Obey',                 name = 'Tenf R',               category = 'Sports' },
    { model = 'gbvivantgrb',     brand = 'Bordeaux',             name = 'Vivant GRB',           category = 'Sports' },
    { model = 'gbarcherpro2',    brand = 'Maibatsu',             name = 'Archer Pro II',        category = 'Sports' },
    { model = 'gbargento2f',     brand = 'Obey',                 name = 'Argento 2F',           category = 'Sports' },
    { model = 'gbargento7fs',    brand = 'Obey',                 name = 'Argento 7F Sportsback', category = 'Sports' },
    { model = 'gbcyphergts',     brand = 'Ubermacht',            name = 'Cypher GTS',           category = 'Sports' },
    { model = 'gbechelon',       brand = 'BF',                   name = 'Echelon',              category = 'Sports' },
    { model = 'gbechelons',      brand = 'BF',                   name = 'Echelon Sportsback',   category = 'Sports' },
    { model = 'gbretinueloz',    brand = 'Vapid',                name = 'Retinue Lozspeed',     category = 'Sports' },
    { model = 'gbromulus',       brand = 'Annis',                name = 'Romulus',              category = 'Sports' },
    { model = 'gbrumina',        brand = 'Annis',                name = 'Rumina',               category = 'Sports' },

    -- Sports Classic
    { model = 'gbcometcl',       brand = 'Pfister',              name = 'Comet Classic',        category = 'Sports Classic' },
    { model = 'gbcomets1t',      brand = 'Pfister',              name = 'Comet S1 Turbo',       category = 'Sports Classic' },
    { model = 'gbkomodagt',      brand = 'Lampadati',            name = 'Komoda GT',            category = 'Sports Classic' },
    { model = 'gbraidillon',     brand = 'Toundra',              name = 'Raidillon',            category = 'Sports Classic' },
    { model = 'gbsidewinder',    brand = 'Maxwell',              name = 'Sidewinder',           category = 'Sports Classic' },
    { model = 'gbturismogt',     brand = 'Grotti',               name = 'Turismo GT',           category = 'Sports Classic' },
    { model = 'gbturismogts',    brand = 'Grotti',               name = 'Turismo GTS',          category = 'Sports Classic' },
    { model = 'gbcometclf',      brand = 'Pfister',              name = 'Comet Classic Florio', category = 'Sports Classic' },
    { model = 'gbcomets1tf',     brand = 'Pfister',              name = 'Comet S1 Turbo Florio', category = 'Sports Classic' },
    { model = 'gbelegyrh2',      brand = 'Annis',                name = 'Elegy RH2',            category = 'Sports Classic' },

    -- Muscle
    { model = 'gbdominatorgsx',  brand = 'Vapid',                name = 'Dominator GSX',        category = 'Muscle' },
    { model = 'gbhades',         brand = 'Dundreary',            name = 'Hades',                category = 'Muscle' },
    { model = 'gbtahomagt',      brand = 'Declasse',             name = 'Tahoma GT',            category = 'Muscle' },
    { model = 'gbhurricane',     brand = 'Brute',                name = 'Hurricane',            category = 'Muscle' },
    { model = 'gbimpalerdlx',    brand = 'Declasse',             name = 'Impaler Deluxe',       category = 'Muscle' },
    { model = 'gbvigerorat',     brand = 'Declasse',             name = 'Vigero Rattler',       category = 'Muscle' },

    -- Compacts
    { model = 'gbbriosof',       brand = 'Grotti',               name = 'Brioso Fulmine',       category = 'Compacts' },
    { model = 'gbclubxr',        brand = 'BF',                   name = 'Club XR',              category = 'Compacts' },
    { model = 'gbirisz',         brand = 'Bollokan',             name = 'Iris Z',               category = 'Compacts' },
    { model = 'gbissimetro',     brand = 'Weeny',                name = 'Issi Metro',             category = 'Compacts' },
    { model = 'gbvivant',        brand = 'Bordeaux',             name = 'Vivant',               category = 'Compacts' },
    { model = 'gbmochi',         brand = 'Annis',                name = 'Mochi',                category = 'Compacts' },

    -- SUV
    { model = 'gbgresleystx',    brand = 'Bravado',              name = 'Gresley STX',          category = 'SUV' },
    { model = 'gbstarlight',     brand = 'Vulcar',               name = 'Starlight',            category = 'SUV' },
    { model = 'gberotiq',        brand = 'Bollokan',             name = 'E-Rotiq',              category = 'SUV' },
    { model = 'gbscoutgsx',      brand = 'Vapid',                name = 'Scout GSX',            category = 'SUV' },

    -- Coupes
    { model = 'gbsapphire',      brand = 'Enus',                 name = 'Sapphire',             category = 'Coupes' },

    -- Vans
    { model = 'gbbisonstx',      brand = 'Bravado',              name = 'Bison STX',            category = 'Vans' },
    { model = 'gbboxboy',        brand = 'Brute',                name = 'Boxboy',               category = 'Vans' },
    { model = 'gbboxboyft',      brand = 'Brute',                name = 'Boxboy Food Truck',    category = 'Vans' },
    { model = 'gbesperta',       brand = 'Bravado',              name = 'Esperta',              category = 'Vans' },
    { model = 'gbesurfer',       brand = 'BF',                   name = 'e-Surfer',             category = 'Vans' },
    { model = 'gbsteedcrew',     brand = 'Vapid',                name = 'Steed Crewmate',       category = 'Vans' },
    { model = 'gbsteedvan',      brand = 'Vapid',                name = 'Steed',                category = 'Vans' },

    -- Offroad
    { model = 'gbbisonhf',       brand = 'Bravado',              name = 'Bison HF',             category = 'Offroad' },
    { model = 'gblod4',          brand = 'Coil',                 name = 'LOD 4',                category = 'Offroad' },
    { model = 'gbmojave',        brand = 'Karin',                name = 'Mojave',               category = 'Offroad' },
    { model = 'gbterrorizer',    brand = 'HVY',                  name = 'Terrorizer',           category = 'Offroad' },

    -- Service
    { model = 'gbtaxiargento7f', brand = 'Obey',                 name = 'Argento 7F Taxi',      category = 'Service' },
    { model = 'gbtaxieon',       brand = 'Coil',                 name = 'Eon Taxi',             category = 'Service' },
    { model = 'gbtaxistanierle', brand = 'Vapid',                name = 'Stainer LE Taxi',      category = 'Service' },
    { model = 'gbtaxistarlight', brand = 'Vulcar',               name = 'Starlight Taxi',       category = 'Service' },
    { model = 'gbvoyagerg',      brand = 'MTL',                  name = 'Voyager Trash Truck',  category = 'Service' },

    -- Commercial
    { model = 'gbvoyager',       brand = 'MTL',                  name = 'Voyager 6x4-T',        category = 'Commercial' },
    { model = 'gbvoyager2',      brand = 'MTL',                  name = 'Voyager 4x2-T',        category = 'Commercial' },
    { model = 'gbvoyagerb',      brand = 'MTL',                  name = 'Voyager 6x4-B',        category = 'Commercial' },
    { model = 'gbvoyagerb2',     brand = 'MTL',                  name = 'Voyager 4x2-B',        category = 'Commercial' },
    { model = 'gbvoyagerh',      brand = 'MTL',                  name = 'Voyager 6x2-H',        category = 'Commercial' },
    { model = 'gbdelivere',      brand = 'Hijak',                name = 'Deliver-E',            category = 'Commercial' },

    -- Emergency
    { model = 'gbemsbisonstx',      brand = 'Bravado',   name = 'Bison STX Ambulance',    category = 'Emergency' },
    { model = 'gbemsesperta',       brand = 'Bravado',   name = 'Esperta Ambulance',      category = 'Emergency' },
    { model = 'gbfirevoyager',      brand = 'MTL',       name = 'Voyager Fire Truck',     category = 'Emergency' },
    { model = 'gbpolbisonhf',       brand = 'Bravado',   name = 'Bison HF Police',        category = 'Emergency' },
    { model = 'gbpolbisonstx',      brand = 'Bravado',   name = 'Bison STX Police',       category = 'Emergency' },
    { model = 'gbpolcometcl',       brand = 'Pfister',   name = 'Comet Classic Police',   category = 'Emergency' },
    { model = 'gbpolcomets2r',      brand = 'Pfister',   name = 'Comet S2R Police',       category = 'Emergency' },
    { model = 'gbpoldomgsx',        brand = 'Vapid',     name = 'Dominator GSX Police',   category = 'Emergency' },
    { model = 'gbpolprospero',      brand = 'Pegassi',   name = 'Prospero Police',          category = 'Emergency' },
    { model = 'gbpolsolace',        brand = 'Dewbauchee', name = 'Solace Police',         category = 'Emergency' },
    { model = 'gbpolstanier',       brand = 'Vapid',     name = 'Stainer LE Police',      category = 'Emergency' },
    { model = 'gbpolstarlight',     brand = 'Vulcar',    name = 'Starlight Police',       category = 'Emergency' },
    { model = 'gbpolsultanrsx',     brand = 'Karin',     name = 'Sultan RSX Police',      category = 'Emergency' },
    { model = 'gbpoltahomagt',      brand = 'Declasse',  name = 'Tahoma GT Police',       category = 'Emergency' },
    { model = 'gbpoltr3s',          brand = 'Progen',    name = 'TR3-S Police',           category = 'Emergency' },
    { model = 'gbpolturismogt',     brand = 'Grotti',    name = 'Turismo GT Police',      category = 'Emergency' },
    { model = 'gbemssteed',         brand = 'Vapid',     name = 'Steed Ambulance',        category = 'Emergency' },
    { model = 'gbpoladmiral',       brand = 'Vapid',     name = 'Admiral Police',         category = 'Emergency' },
    { model = 'gbpolargento7f',     brand = 'Obey',      name = 'Argento 7F Police',      category = 'Emergency' },
    { model = 'gbpolbanshees',      brand = 'Bravado',   name = 'Banshee S Police',       category = 'Emergency' },
    { model = 'gbpolclubxr',        brand = 'BF',        name = 'Club XR Police',         category = 'Emergency' },
    { model = 'gbpolechelon',       brand = 'BF',        name = 'Echelon Police',         category = 'Emergency' },
    { model = 'gbpoleon',           brand = 'Coil',      name = 'Eon Police',             category = 'Emergency' },
    { model = 'gbpolesperta',       brand = 'Bravado',   name = 'Esperta Police',         category = 'Emergency' },
    { model = 'gbpolgresley',       brand = 'Bravado',   name = 'Gresley Police',         category = 'Emergency' },
    { model = 'gbpolhedra',         brand = 'Vulcar',    name = 'Hedra Police',           category = 'Emergency' },
    { model = 'gbpolimpaler',       brand = 'Declasse',  name = 'Impaler Police',         category = 'Emergency' },
    { model = 'gbpolmojave',        brand = 'Karin',     name = 'Mojave Police',          category = 'Emergency' },
    { model = 'gbpolscoutgsx',      brand = 'Vapid',     name = 'Scout GSX Police',       category = 'Emergency' },
    { model = 'gbpolsentinelgts',   brand = 'Ubermacht', name = 'Sentinel GTS Police',    category = 'Emergency' },
    { model = 'gbpolsteedvan',      brand = 'Vapid',     name = 'Steed Police',           category = 'Emergency' },
    { model = 'gbpolterrorizer',    brand = 'HVY',       name = 'Terrorizer Police',      category = 'Emergency' },
}