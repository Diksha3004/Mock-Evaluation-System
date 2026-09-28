package com.mockevaluation.model;

public class Assignment {

    private long assignmentId;
    private long participantId;
    private long evaluatorId;
    private long roundId;

    public long getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(long assignmentId) {
        this.assignmentId = assignmentId;
    }

    public long getParticipantId() {
        return participantId;
    }

    public void setParticipantId(long participantId) {
        this.participantId = participantId;
    }

    public long getEvaluatorId() {
        return evaluatorId;
    }

    public void setEvaluatorId(long evaluatorId) {
        this.evaluatorId = evaluatorId;
    }

    public long getRoundId() {
        return roundId;
    }

    public void setRoundId(long roundId) {
        this.roundId = roundId;
    }
}