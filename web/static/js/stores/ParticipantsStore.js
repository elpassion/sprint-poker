var Actions = require('../actions/ParticipantsActions');

var ParticipantsStore = Reflux.createStore({
  listenables: [Actions],

  init() {
    this.participants = [];
    this.error = {};
  },

  getInitialState() {
    return this.returnData();
  },

  returnData() {
    return {
      participants: this.participants,
      error: this.error
    };
  },

  emitData() {
    this.trigger(this.returnData());
  },

  onSetParticipants(participants) {
    this.participants = participants;
    this.emitData();
  },

  onAddParticipant(participant) {
    var exists = _.find(this.participants, { id: participant.id } );
    if(!exists) {
      this.participants.push(participant);
      this.emitData();
    }
  },

  onRemoveParticipant(participantId) {
    _.remove(this.participants, { id: participantId });
    this.emitData();
  }
});

module.exports = ParticipantsStore;
