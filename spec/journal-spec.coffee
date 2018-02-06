Journal = require '../lib/journal'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'Journal', ->
  describe 'when specs are written', ->
    it 'tests are appropriate to the package and are useful', ->
      expect('tests').toBe 'appropriate and useful'
