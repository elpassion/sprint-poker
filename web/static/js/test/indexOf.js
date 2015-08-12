var assert = require("assert");
describe('Array',()  => {
  describe('#indexOf()', () => {
    it('should return -1 when the value is not present', () => {
      assert.equal(-1, [1,2,3].indexOf(5));
    });

    it('should not return -1 when the value is present', () => {
      assert.notEqual(-1, [1,2,3].indexOf(1));
    });
  });
});
