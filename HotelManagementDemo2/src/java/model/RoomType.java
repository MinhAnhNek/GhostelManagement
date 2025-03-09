package model;

public class RoomType {
    private int id, capacity;
    private String name;
    private String description;

    public RoomType(int id, String name, int capacity, String description) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public int getCapacity() {
        return capacity;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }
}
