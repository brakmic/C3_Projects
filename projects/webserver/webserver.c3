module minimal_api;

import std::io;
import libc;

// libmicrohttpd bindings
extern fn void* start_daemon(uint flags, ushort port, void* apc, void* apc_cls, void* dh, void* dh_cls, ...) @extern("MHD_start_daemon");
extern fn void stop_daemon(void* daemon) @extern("MHD_stop_daemon");
extern fn void* create_response_from_buffer(usz size, void* buffer, uint mode) @extern("MHD_create_response_from_buffer");
extern fn void destroy_response(void* response) @extern("MHD_destroy_response");
extern fn int queue_response(void* connection, uint status_code, void* response) @extern("MHD_queue_response");
extern fn int add_response_header(void* response, char* header, char* content) @extern("MHD_add_response_header");

const uint MHD_USE_INTERNAL_POLLING_THREAD = 1;
const uint MHD_USE_SELECT_INTERNALLY = 4;
const uint MHD_RESPMEM_PERSISTENT = 0;
const uint MHD_HTTP_OK = 200;
const int MHD_YES = 1;
const int MHD_NO = 0;

// API endpoint handler
fn int request_handler(void* cls, void* connection, char* url, char* method, char* version, char* upload_data, usz* upload_data_size, void** con_cls) @extern("request_handler") {
    
    io::printfn("📡 Handler called: %s %s", method, url);
    
    String json = `{"message": "Hello from C3!", "status": "ok"}`;
    
    void* response = create_response_from_buffer(json.len, (void*)json.ptr, MHD_RESPMEM_PERSISTENT);
    if (!response) {
        io::printn("❌ Failed to create response");
        return MHD_NO;
    }
    
    add_response_header(response, "Content-Type", "application/json");
    
    int queue_result = queue_response(connection, MHD_HTTP_OK, response);
    io::printfn("📤 Response queued with result: %d", queue_result);
    
    destroy_response(response);
    
    io::printn("✅ Handler returning MHD_YES");
    return MHD_YES;
}

fn void main() {
    io::printn("Starting minimal C3 API server on port 8080...");
    
    // Try with different daemon flags
    void* daemon = start_daemon(MHD_USE_SELECT_INTERNALLY, 8080, null, null, &request_handler, null, 0);
    
    if (!daemon) {
        io::printn("❌ Failed to start server!");
        return;
    }
    
    io::printn("✅ Server started successfully!");
    io::printn("🌐 Try: curl http://localhost:8080");
    io::printn("🌐 Or open: http://localhost:8080");
    io::printn("Press Enter to stop...");
    
    libc::getchar();
    
    stop_daemon(daemon);
    io::printn("🛑 Server stopped.");
}
