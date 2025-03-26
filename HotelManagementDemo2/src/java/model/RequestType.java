package model;

public class RequestType {
    private int typeID;
    private String typeName;

    public int getId() {
        return typeID;
    }

    public String getName() {
        return typeName;
    }

    public RequestType(int typeID, String typeName) {
        this.typeID = typeID;
        this.typeName = typeName;
    }
}
