var move_speed = 2;

var move_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
var move_right = keyboard_check(vk_right) or keyboard_check(ord("D"));
var move_up = keyboard_check(vk_up) or keyboard_check(ord("W"));
var move_down = keyboard_check(vk_down) or keyboard_check(ord("S"));

var input_horizontal = move_right - move_left;
var input_vertical = move_down - move_up;

x += input_horizontal * move_speed;
y += input_vertical * move_speed;
// Detectamos si el jugador está colisionando con la zona invisible Object3
if (place_meeting(x, y, Object3)) {
    // Si toca la zona, busca el fondo (Object4) y cámbiale el sprite
    with (Object4) {
        sprite_index = abierto;
    }
} else {
    // Si no está tocando la zona, vuelve al sprite cerrado
    with (Object4) {
        sprite_index = cerrado;
    }
}
// Si está tocando la puerta invisible Object3 y presiona la tecla Espacio
if (place_meeting(x, y, Object3) && keyboard_check_pressed(vk_space)) {
    room_goto(Room2); // Te cambia a la nueva sala
}
// Comprobamos si está tocando la puerta invisible Y presiona la tecla Espacio
if (place_meeting(x, y, Object3) && keyboard_check_pressed(vk_space)) {
    
    // Si estamos en Room1, nos lleva a Room2
    if (room == Room1) {
        room_goto(Room2);
    } 
    // Si estamos en Room2, nos regresa a Room1
    else if (room == Room2) {
        room_goto(Room1);
    }
}
// --- SISTEMA DE COMPRA DE PAN ---
var precio_pan = 5;

// Verificamos si Object6 existe en la sala y si estamos colisionando con él
if (instance_exists(Object6) && place_meeting(x, y, Object6)) {
    if (keyboard_check_pressed(vk_space)) {
        
        if (monedas >= precio_pan && !tiene_pan) {
            monedas -= precio_pan;
            tiene_pan = true;
            
            show_debug_message("¡Compraste un pan! Te quedan: " + string(monedas) + " monedas.");
            
            // Destruimos la instancia del pan que acabas de tocar
            var pan_instancia = instance_place(x, y, Object6);
            if (pan_instancia != noone) {
                with (pan_instancia) {
                    instance_destroy();
                }
            }
        } 
        else if (tiene_pan) {
            show_debug_message("Ya llevas un pan en la mano.");
        } 
        else {
            show_debug_message("No tienes suficientes monedas.");
        }
    }
}
// 1. Iniciar el salto al presionar Espacio si está en el suelo
if (keyboard_check_pressed(vk_space) && en_suelo) {
    // Solo salta si NO está sobre la puerta o la tienda para evitar conflictos de interacción
    if (!place_meeting(x, y, Object3) && !place_meeting(x, y, Object6)) {
        z_speed = fuerza_salto;
        en_suelo = false;
    }
}

// 2. Si está en el aire, aplicar la gravedad y mover la posición vertical
if (!en_suelo) {
    z += z_speed;
    z_speed -= grav;
    y -= z_speed; // Mueve al personaje visualmente hacia arriba y abajo

    // Al caer de vuelta a su punto de origen
    if (z <= 0) {
        z = 0;
        z_speed = 0;
        en_suelo = true;
    }
}