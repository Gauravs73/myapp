import React, { useEffect, useState } from 'react';

function App() {
  const [msg, setMsg] = useState("");

  useEffect(() => {
    fetch('/api/hello')
      .then(res => res.json())
      .then(data => setMsg(data.message));
  }, []);

  return (
    <div style={{ padding: '2rem' }}>
      <h1>React + Node Azure App</h1>
      <p>{msg}</p>
    </div>
  );
}

export default App;