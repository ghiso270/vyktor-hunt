if(!variable_instance_exists(id, "meter_data"))
	meter_data = global.blood_meter_data;

// note: everythin is in %, so it ranges from 0 (empty) to 100 (full)
capacity = meter_data.capacity;
starting_blood = meter_data.starting_blood;
current_blood = starting_blood;

height = 55;
width  = BAR_LENGTH_SCALE*capacity;

x1 = wrap(meter_data.xpos, 0, RES_WIDTH-width);
y1 = wrap(meter_data.ypos, 0, RES_HEIGHT-height);
x2 = x1 + width;
y2 = y1 + height;

// angle (0=flat)
rad = height;

outline=true;
routline=false;

trasfer_timer = global.blood_transfer_frequency;
number = meter_data.number;
selected = false;

outline_color_selected	= c_white;
outline_color			= c_black;
bg_color_selected		= #808080;
bg_color				= c_dkgrey;
bar_color				= meter_data.color;
text_color				= c_black;


// thickness of outline
thickness = 4;

// below this blood level, the angle becomes wrong, so it must be fixed
bar_threshold = 80/BAR_LENGTH_SCALE;

surf_size = 1024;
bg_surf = -1;
cutter = -1;
surf = -1;

// for performance saving
cache_blood = current_blood;
