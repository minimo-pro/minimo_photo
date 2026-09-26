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

## Failure rules

- Picker errors show a snackbar and keep the existing batch.
- A null/missing compressor output marks that photo failed.
- Less than 10% savings marks it skipped and removes the temp output.
- Save/share errors show a snackbar. Replacement deletes originals only after
  every compressed photo has been saved successfully.
- Holding cancel invalidates the run and deletes generated temp outputs.
