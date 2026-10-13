# Results and Errors

The result screen lists each photo status and calculates saved bytes from
successful items only. Skipped and failed items are never offered for save or
share.

## Actions

- **VS:** split original/compressed image with pan and zoom
- **Save:** Android saves a new gallery photo directly. iOS offers save as new,
  preserve the original gallery metadata, or save then request original deletion.
- **Share:** open system share UI for successful image files
- **Try again:** rerun the current batch after no useful result
- **Exit:** confirm if successful results remain unsaved. Keep imported sources,
  results and previews until exit, even after saving. Wait for active file
  operations, then remove this batch’s temporary files; saved gallery copies
  remain untouched. System back and the on-screen back button share this flow.

## Failure rules

- Picker errors show a snackbar and keep the existing batch.
- A null/missing compressor output marks that photo failed.
- Less than 10% savings marks it skipped and removes the temp output.
- When all items are skipped, the result says there was no useful saving; it
  does not imply the app previously compressed the originals.
- Save/share errors show a snackbar. Replacement deletes originals only after
  every compressed photo has been saved successfully.
- Holding cancel waits for the current encoder, removes generated outputs and
  keeps imported photos for another attempt.
