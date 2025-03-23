package model;

import java.sql.Time;
import java.util.Date;

public class AttendanceCode {
    private int id;
    private String code;
    private Time startTime;
    private Time endTime;
    private Date date;

    public AttendanceCode(int id, String code, Time startTime, Time endTime, Date date) {
        this.id = id;
        this.code = code;
        this.startTime = startTime;
        this.endTime = endTime;
        this.date = date;
    }

    public AttendanceCode(Time startTime, Time endTime) {
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public int getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public Time getStartTime() {
        return startTime;
    }

    public Date getDate() {
        return date;
    }

    public Time getEndTime() {
        return endTime;
    }
}
