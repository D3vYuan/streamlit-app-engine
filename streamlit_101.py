import streamlit as st


def handle_btn_click():
    if "btn_hello" not in st.session_state:
        st.session_state.btn_hello = 0
    st.session_state.btn_hello += 1
    st.write(f"Hello World x {st.session_state.btn_hello}")


def clear_btn_click():
    if "btn_hello" in st.session_state:
        st.session_state.btn_hello = 0
    st.write(f"Hello World x {st.session_state.btn_hello}")
    # st.write("Cleared")


st.title("Hello World")
col1, col2 = st.columns(2)
with col1:
    st.button(label="Hello World", on_click=handle_btn_click)
with col2:
    st.button(label="Reset", on_click=clear_btn_click)
