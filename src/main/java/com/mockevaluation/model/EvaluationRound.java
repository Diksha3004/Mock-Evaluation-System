package com.mockevaluation.model;

public class EvaluationRound {

    private long roundId;
    private String roundName;
    private long technologyId;

    public long getRoundId() {
        return roundId;
    }

    public void setRoundId(long roundId) {
        this.roundId = roundId;
    }

    public String getRoundName() {
        return roundName;
    }

    public void setRoundName(String roundName) {
        this.roundName = roundName;
    }

    public long getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(long technologyId) {
        this.technologyId = technologyId;
    }
}