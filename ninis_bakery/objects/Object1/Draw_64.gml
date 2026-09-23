// Definimos el color y alineación del texto
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Dibujar fondo oscuro semitransparente para mejor visibilidad (Opcional)
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(10, 10, 220, 70, false);
draw_set_alpha(1); // Restaurar opacidad normal

// Dibujar el saldo de monedas
draw_set_color(c_yellow);
draw_text(20, 20, "Monedas: $" + string(monedas));

// Dibujar el estado del inventario (si tiene pan o no)
if (tiene_pan) {
    draw_set_color(c_lime);
    draw_text(20, 45, "Inventario: Pan [x1]");
} else {
    draw_set_color(c_white);
    draw_text(20, 45, "Inventario: Vacio");
}