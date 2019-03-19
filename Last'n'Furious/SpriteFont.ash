
struct SpriteFont
{
  // Images of symbols
  DynamicSprite *Glyphs[];
  // First and last glyphs are symbol codes that define supported range for this font
  int            FirstGlyph;
  int            LastGlyph;
  // Font's height
  int            Height;
  // Glyph width for monospaced (fixed-width) fonts, or default width also used to know letter coordinate for varied-width fonts
  int            GlyphWidth;
  // Individual offsets and widths for each glyth; they are set to 0 and GlyphWidth when the font is created, but can be modified.
  int            Offs[];
  int            Widths[];
  
  // Create font from the static sprite
  import void    CreateFromSprite(DynamicSprite *sprite, int gl_width, int height, int gl_first, int gl_last, 
                                    int offs[], int widths[]);
  // Draws single line of text
  import void    DrawText(String s, DrawingSurface *ds, int x, int y);
  // Draws single line of text centered horizontally in the place starting with x coordinate and having particular width
  import void    DrawTextCentered(String s, DrawingSurface *ds, int x, int y, int width);
  // Deletes font
  import void    Delete();
  // Calculates the width of the line of text
  import int     GetTextWidth(String s);
};
