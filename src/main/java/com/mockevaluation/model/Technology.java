package com.mockevaluation.model;

public class Technology {

    private long technologyId;
    private String technologyName;
    private String description;

    public long getTechnologyId() {
        return technologyId;
    }

    public void setTechnologyId(long technologyId) {
        this.technologyId = technologyId;
    }

    public String getTechnologyName() {
        return technologyName;
    }

    public void setTechnologyName(String technologyName) {
        this.technologyName = technologyName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}