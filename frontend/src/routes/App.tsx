
import logo from '../images/mutiny-logo.svg';

function App() {
  return (
    <div className="flex flex-col h-screen">
      <header className='p-8'>
        <img src={logo} className="App-logo" alt="logo" />
        <h2>You're probably looking for <a href="/tests">the tests</a></h2>
      </header>
      <main className='flex flex-grow flex-col h-full justify-between p-8'>

        <div />
        <h1 className='text-4xl font-light uppercase'>69_420 <span className='text-2xl'>sats</span></h1>
        <div />
        <div className='flex flex-col gap-2 items-start'>

          <button className='green-button'>Send</button>
          <button className='blue-button'>Deposit</button>
        </div>

      </main>
    </div>
  );
}

export default App;