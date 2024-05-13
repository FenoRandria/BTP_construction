function formatBytes(bytes, decimals = 2) {
    if (bytes === 0) return '0 Bytes';
  
    const k = 1000;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  
    const i = Math.floor(Math.log(bytes) / Math.log(k));
  
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
  }
  
  function useFileReader(files) {
    const [images, setImages] = React.useState([]);
  
    React.useEffect(() => {
      const fileReaders = [];
      let isCancel = false;
  
      const promises = files.map(file => {
        return new Promise((resolve, reject) => {
          const fileReader = new FileReader();
          fileReaders.push(fileReader);
          fileReader.onload = e => {
            const { result } = e.target;
            if (result) {
              resolve({
                name: file.name,
                size: file.size,
                formatSize: formatBytes(file.size),
                type: file.type,
                url: result
              });
            }
          };
          fileReader.onabort = () => {
            reject(new Error("File reading aborted"));
          };
          fileReader.onerror = () => {
            reject(new Error("Failed to read file"));
          };
          fileReader.readAsDataURL(file);
        });
      });
  
      Promise.all(promises)
        .then(images => {
          if (!isCancel) {
            setImages(images);
          }
        })
        .catch(reason => {
          console.log(reason);
        });
  
      return () => {
        isCancel = true;
        fileReaders.forEach(fileReader => {
          if (fileReader.readyState === 1) {
            fileReader.abort();
          }
        });
      };
    }, [files]);
  
    return images;
  }
  
  function DragAndDropFiles(props) {
    const {
      label, id,
      accept,
      multiple = false,
      limitSize = 5000000,
      errorTimeout = 3000,
      ...inputProps } = props;
  
    const [files, setFiles] = React.useState([]);
    const [error, setError] = React.useState(null);
    const images = useFileReader(files);
  
    React.useEffect(() => {
      let intervalId = null;
  
      if (error !== null) {
        intervalId = setTimeout(() => {
          setError(null);
        }, errorTimeout);
      }
  
      return () => {
        if (intervalId !== null) {
          clearTimeout(intervalId);
        }
      };
    }, [error]);
  
    const saveFiles = files => {
      for (let i = 0; i < files.length; i++) {
        const file = files.item(i);
        if (file.size < limitSize) {
          setFiles(prev => [...prev, file]);
        } else {
          setError(`File '${file.name}' size is larger than ${formatBytes(limitSize)}`);
        }
      }
    };
  
    const handleChange = e => {
      const { files } = e.target;
      saveFiles(files);
    };
  
    const handleDrop = e => {
      e.preventDefault();
      e.stopPropagation();
      if (e.dataTransfer.files && e.dataTransfer.files.length) {
        saveFiles(e.dataTransfer.files);
      }
    };
  
    const getIconType = type => {
      const iconTypes = {
        'image/png': 'fa-file-image',
        'application/pdf': 'fa-file-pdf'
      };
  
      return iconTypes[type] || 'fa-file';
    };
  
    const deleteFile = index => {
      const copy = [...files];
      copy.splice(index, 1);
      setFiles(copy);
    };
  
    const totalSize = files.reduce((prev, { size }) => prev + size, 0);
  
    return (
      <section className="input-file">
        <section className="input-file--box" onDrop={handleDrop}>
          <i className="fa fa-cloud-arrow-up input-file--icon"></i>
          <label htmlFor={id}>{label}</label>
          <span>Max size ({formatBytes(limitSize)})</span>
          <input {...inputProps} id={id} type="file" accept={accept} multiple onChange={handleChange} />
        </section>
        {error && <span className="error">{error}</span>}
        <span className="total-info">{files.length} files - {formatBytes(totalSize)}</span>
        <section className="input-file--files">
          {images.map((image, key) => (
            <section key={key} className="image-card">
              <section className="image-card--image">
                <i className={`fa ${getIconType(image.type)} image-card--icon`}></i>
              </section>
              <section className="image-card--data">
                <p className="image-card--name">{image.name}</p>
                <p className="image-card--size" title={`${image.size} bytes`}>{image.formatSize}</p>
              </section>
              <section className="image-card--delete" onClick={() => deleteFile(key)}>
                <i className="fa fa-trash-can image-card--delete--icon"></i>
              </section>
            </section>
          ))}
        </section>
      </section>
    );
  }
  
  function App() {
    return (
      <section>
        <DragAndDropFiles label="Click to upload or drag and drop" id="file" limitSize={5000000} />
      </section>
    );
  }
  
  ReactDOM.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
    document.getElementById('root')
  );
  