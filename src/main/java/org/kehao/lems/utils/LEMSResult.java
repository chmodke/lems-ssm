package org.kehao.lems.utils;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Created by kehao on 2017/4/20.
 */
public class LEMSResult {
    private Object data;
    private int status;
    private String message;

    public Object getData() {
        return data;
    }

    public int getStatus() {
        return status;
    }

    public String getMessage() {
        return message;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
